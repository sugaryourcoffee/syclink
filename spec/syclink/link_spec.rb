require 'syclink/link'

module SycLink

  describe Link do

    before do 
      @link = Link.new("http://example.com")
      @link_complete = Link.new("http://example.com", 
                                { title:       "Example",
                                  description: "For testing purposes",
                                  tag:         "Test" })
    end

    it "should create a link" do
      expect(@link.url).to eq "http://example.com"
      expect(@link.title).to eq "http://example.com"
      expect(@link.description).to be_empty
      expect(@link.tag).to eq "untagged"
    end

    it "should update a link" do
      @link.update({title:       "Example",
                   description: "For testing purposes",
                   tag:         "Test"})
      expect(@link.title).to       eq "Example"
      expect(@link.description).to eq "For testing purposes"
      expect(@link.tag).to         eq "Test"
    end

    it "should return true if search attributes match" do
      expect(@link_complete.match?({url: "http://example.com"})).to be_true
      expect(@link_complete.match?({url: "http://example.de"})).to  be_false
      expect(@link_complete.match?({url: "http://example.com",
                                    title: "Example"})).to          be_true
      expect(@link_complete.match?({description: "For testing purposes",
                                    tag:         "Test"})).to       be_true
      expect(@link_complete.match?({tag: "Test"})).to               be_true
    end

    it "should return true if search string is part of link attributes" do
      expect(@link_complete.contains?("example.com")).to be_true
    end
  end

end
