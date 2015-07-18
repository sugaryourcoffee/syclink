require 'syclink/website'

module SycLink

  describe Website do
    
    before do
      @link  = Link.new("http://example.com",
                        { name:       "Example",
                          description: "An example website",
                          tag:         "Test" })
      @link2 = Link.new("http://example.com",
                        { name:       "Challenge",
                          description: "An example website",
                          tag:         "Tag" })
      @link3 = Link.new("http://challenge.com",
                        { name:       "Challenge",
                          description: "An example website",
                          tag:         "Tag" })
      @link4 = Link.new("http://challenge.com",
                        { name:       "Challenge",
                          description: "An example website",
                          tag:         "One,Two" })
      @website = Website.new("Link List")
      @template = <<-HERE.gsub(/^ {8}/, '')
        <html>
          <h1><%= title %></h1>
          <% links.each do |link| %>
            <a href='<%= link.url %>'><%= link.name %></a>
            <%= link.description %> <%= link.tag %>
          <% end %>
        </html> 
      HERE
    end

    it "should add link" do
      expect(@website.links).to eq []
      @website.add_link(@link)
      expect(@website.links).to eq [@link]
    end

    it "should delete link" do
      @website.add_link(@link)
      @website.remove_link(@link)
      expect(@website.links).to eq []
    end

    it "should list links based on attributes" do
      @website.add_link(@link)
      expect(@website.list_links({name: "not there"}).size).to eq 0
      expect(@website.list_links({name: "Example"}).size).to   eq 1
      expect(@website.list_links.size).to                       eq 1
    end

    it "should find links based on search string" do
      @website.add_link(@link)
      expect(@website.find_links("example.com")).to eq [@link]
      expect(@website.find_links("website")).to     eq [@link]
      expect(@website.find_links("nothing")).to     eq []
    end

    it "should merge links with same url" do
      @website.add_link(@link)
      @website.add_link(@link2)
      @website.add_link(@link3)
      expect(@website.links.size).to eq 3
      @website.merge_links_on(:url, "+")
      expect(@website.links.size).to eq 2
    end

    it "should export links to csv" do
      @website.add_link(@link)
      @website.add_link(@link3)

      result = <<-HERE.gsub(/^ {8}|\n$/, '')
        http://example.com;Example;An example website;Test
        http://challenge.com;Challenge;An example website;Tag
      HERE
 
      expect(@website.to_csv).to eq result
    end

    it "should create the html representation" do
      @website.add_link(@link)
      html = @website.to_html(@template)
      expect(html).to include("<a href='http://example.com'>")
      expect(html).to include("Example")
      expect(html).to include("An example website")
      expect(html).to include("Test")
    end

    it "should group links on tags" do
      @website.add_link(@link)
      @website.add_link(@link)
      target = { "Test" => [@link, @link] }
      expect(@website.links_group_by(:tag)).to eq target
    end

    it "should duplicate links on multiple tags" do
      @website.add_link(@link4)

      links = @website.links_duplicate_on(:tag, ',')

      expect(links.size).to eq 2

      expect(links.first.url).to         eq "http://challenge.com"
      expect(links.first.name).to        eq "Challenge"
      expect(links.first.description).to eq "An example website"
      expect(links.first.tag).to         eq "One"
    end

    it "should group links on tags and separated multiple tags" do
      @website.add_link(@link)
      @website.add_link(@link4)
      expect(@website.links_group_by_separated(:tag, ',').size).to eq 3
    end

    it "should list all tags" do
      @website.add_link(@link)
      @website.add_link(@link)
      target = [ @link.tag ]
      expect(@website.link_attribute_list(:tag)).to eq target
    end

    it "should list allt tags and multiple tags separated to single tags" do
      @website.add_link(@link)
      @website.add_link(@link4)
      target = [@link.tag, @link4.tag.split(',')].flatten.sort
      expect(@website.link_attribute_list(:tag, ',')).to eq target
    end
  end

end
