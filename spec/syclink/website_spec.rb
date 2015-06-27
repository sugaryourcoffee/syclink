require 'syclink/website'

module SycLink

  describe Website do
    
    before do
      @link = Link.new("http://example.com",
                       { title:       "Example",
                         description: "An example website",
                         tag:         "Test" })
      @website = Website.new("Link List")
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

    it "should create the html representation"

    it "should load links from file"

  end

end
