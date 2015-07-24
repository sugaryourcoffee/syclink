require 'syclink/designer'

module SycLink

  describe Designer do

    before do 
      @designer = Designer.new
      @designer.new_website("Test Site")
    end

    it "should add a link" do
      @designer.add_link("http://example.com",
                         { name: "Example",
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

    it "should find a link" do
      @designer.add_link("http://example.com",
                         { name: "Example",
                           description: "An example website",
                           tag: "Test" })
      expect(@designer.find_links("http://example.com")).to be_truthy
    end

    it "should update a link" do
      @designer.add_link("http://example.com",
                         { name: "Example",
                           description: "An example website",
                           tag: "Test" })
      @designer.update_link("http://example.com",
                            { name: "Reality",
                              description: "A reality website",
                              tag: "Reality" })

      expect(@designer.find_links("http://example.com")
                      .first.name).to eq "Reality"
    end

    it "should update links from a file" do
      links = [ "http://example.com;Example;An example website;Test",
                "http://test.de;test;A test website;Test",
                "http://challenge.org;challenge;A challenge website;Challenge" ]
      File.write("links.tmp", links.join("\n"))

      @designer.add_links_from_file("links.tmp")
      expect(@designer.website.links.size).to eq 3

      links = [ "http://example.com;example.com;An example website;Example",
                "http://test.de;test;A test website;Test,What",
                "http://challenge.org;challenge;Challenge website;Challenge" ]
      File.write("links.tmp", links.join("\n"))

      @designer.update_links_from_file("links.tmp")
      expect(@designer.website.links.size).to eq 3
      expect(@designer.website.links[0].name).to        eq "example.com"
      expect(@designer.website.links[1].tag).to         eq "Test,What"
      expect(@designer.website.links[2].description).to eq "Challenge website"


      FileUtils.rm("links.tmp")
    end

    it "should list all links" do
      @designer.add_link("http://example.com",
                         { name: "Example",
                           description: "An example website",
                           tag: "Test" })

      expect(@designer.list_links).to eq @designer.website.links
    end

    it "should list links based on attributes" do
      @designer.add_link("http://example.com",
                         { name: "Example",
                           description: "An example website",
                           tag: "Test" })
      @designer.add_link("http://example.com",
                         { name: "Reality",
                           description: "A reality website",
                           tag: "Reality" })

      expect(@designer.list_links({name: "Reality"}).size).to eq 1
    end

    it "should delete a link" do
      @designer.add_link("http://example.com",
                         { tag: "Example", name: "Link" })
      @designer.add_link("http://reality.com",
                         { tag: "Reality", name: "URL" })
       
      expect(@designer.list_links.size).to eq 2
      @designer.remove_links(["http://reality.com"])
      expect(@designer.list_links.size).to eq 1
    end

    it "should delete links from a file" do
      links = [ "http://example.com;Example;An example website;Test",
                "http://test.de;test;A test website;Test",
                "http://challenge.org;challenge;A challenge website;Challenge" ]
      File.write("links.tmp", links.join("\n"))

      @designer.add_links_from_file("links.tmp")
      expect(@designer.website.links.size).to eq 3

      links = [ "http://example.com",
                "",
                "http://challenge.org" ]
      File.write("links.tmp", links.join("\n"))

      @designer.remove_links_from_file("links.tmp")
      expect(@designer.website.links.size).to eq 1
      expect(@designer.website.links[0].name).to        eq "test"
      expect(@designer.website.links[0].tag).to         eq "Test"
      expect(@designer.website.links[0].description).to eq "A test website"

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
