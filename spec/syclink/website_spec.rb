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

    it "should list all links"

    it "should find links based on search string"

    it "should find links based on tags"

    it "should create the html representation"

  end

end
