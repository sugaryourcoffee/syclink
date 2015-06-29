require 'syclink/designer.rb'

module SycLink

  describe Designer do

    before do 
      @designer = Designer.new
      @designer.new_website("Test Site")
    end

    it "should add a link" do
      @designer.add_link("http://example.com",
                         { title: "Example",
                           description: "An example website",
                           tag: "Test"  })

      expect(@designer.website.links.size).to eq 1
    end

    it "should add links from a file" do
      links = [ "http://example.com;Example;An example website;Test",
                "http://test.de;A test website;Test",
                "http://challenge.org;A challenge website;Challenge" ]
      File.write("links.tmp", links.join("\n"))

      @designer.add_links_from_file("links.tmp")
      expect(@designer.website.links.size).to eq 3

      FileUtils.rm("links.tmp")
    end

    it "should save, load and delete a website" do
      @designer.add_link("http://example.com",
                         { tag: "Loader" })
      @designer.save_website(".")
      @designer.load_website("test-site.website")
      expect(@designer.website.title).to eq "Test Site"
      @designer.delete_website(".")
      expect(Dir["./website.website"]).to be_empty
    end

  end

end
