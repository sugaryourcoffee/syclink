require 'syclink/link'

module SycLink

  describe Link do

    before do 
      @link = Link.new("http://example.com")
      @link_complete = Link.new("http://example.com", 
                                { name:        "Example",
                                  description: "For testing purposes",
                                  tag:         "Test" })
    end

    it "should respond to LinkChecker methods" do
      expect(@link).to respond_to :response
      expect(@link).to respond_to :response_of_uri
      expect(@link).to respond_to :response_of_file
    end

    it "should create a link" do
      expect(@link.url).to eq "http://example.com"
      expect(@link.name).to eq "http://example.com"
      expect(@link.description).to be_empty
      expect(@link.tag).to eq "untagged"
    end

    it "should update a link" do
      @link.update({name:       "Example",
                   description: "For testing purposes",
                   tag:         "Test"})
      expect(@link.name).to        eq "Example"
      expect(@link.description).to eq "For testing purposes"
      expect(@link.tag).to         eq "Test"
    end

    it "should return true if search attributes match" do
      expect(@link_complete.match?({url: "http://example.com"})).to be_truthy
      expect(@link_complete.match?({url: "http://example.de"})).to  be_falsey
      expect(@link_complete.match?({url: "http://example.com",
                                    name: "Example"})).to           be_truthy
      expect(@link_complete.match?({description: "For testing purposes",
                                    tag:         "Test"})).to       be_truthy
      expect(@link_complete.match?({tag: "Test"})).to               be_truthy
    end

    it "should return true if search string is part of link attributes" do
      expect(@link_complete.contains?("example.com")).to        be_truthy
      expect(@link_complete.contains?("nothing")).to            be_falsey
      expect(@link_complete.contains?("http://example.com")).to be_truthy
      expect(@link_complete.contains?("HTTP://EXAMPLE.com")).to be_truthy
    end

    it "should return the values of the link" do
      expect(@link_complete.row).to eq [ "http://example.com", "Example",
                                         "For testing purposes", "Test" ]
    end
  end

end
