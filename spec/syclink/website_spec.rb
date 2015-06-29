require 'syclink/website'

module SycLink

  describe Website do
    
    before do
      @link = Link.new("http://example.com",
                       { title:       "Example",
                         description: "An example website",
                         tag:         "Test" })
      @website = Website.new("Link List")
      @template = <<-HERE.gsub(/^ {8}/, '')
        <html>
          <h1><%= title %></h1>
          <% links.each do |link| %>
            <a href='<%= link.url %>'><%= link.title %></a>
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

    it "should find links based on search string" do
      @website.add_link(@link)
      expect(@website.find_links("example.com")).to eq [@link]
      expect(@website.find_links("website")).to     eq [@link]
      expect(@website.find_links("nothing")).to     eq []
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

    it "should list all tags" do
      @website.add_link(@link)
      @website.add_link(@link)
      target = [ @link.tag ]
      expect(@website.link_attribute_list(:tag)).to eq target
    end

  end

end
