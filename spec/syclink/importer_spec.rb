require 'syclink/firefox'
require 'syclink/chrome'
require 'syclink/internet_explorer'

module SycLink

  describe Importer do

    describe "Firefox" do
    
      before do
        @import = [ [ "http://a.com", "a", "at", "a site", nil,  "aa" ],
                    [ "http://b.com", "b", "bt", nil,      "ab", "bb" ],
                    [ "http://c.com", nil, "ct", "b site", "bc", nil  ] ] 
        
        @result = [ [ "http://a.com", "a",  "a site", "aa"    ],
                    [ "http://b.com", "b",  "",       "ab,bb" ],
                    [ "http://c.com", "ct", "b site", "bc"    ] ]

        @firefox = Firefox.new(@import)
      end

      it "should create rows" do
        # expect(@firefox.rows(path_to_data_base)).to eq  @result
      end
      
      it "should create links" do
        # links = @firefox.links(path_to_database)
        # expect(links.first.url).to         eq @result.first[0]
        # expect(links.first.name).to        eq @result.first[1]
        # expect(links.first.description).to eq @result.first[2]
        # expect(links.first.tag).to         eq @result.first[3]
      end

    end

    describe "Internet Explorer" do

      before do
        @ie_directory = File.join(File.dirname(__FILE__), 'ie/')
        @result = [ [ "http://www.example.com/", "ie.txt", "", "one" ],
                    [ "http://www.example.com/", "ie.txt", "", "one,two"],
                    [ "http://www.example.com/", "ie.txt", "", ""] ]

        @ie = InternetExplorer.new
      end

      it "should import bookmarks" do
        expect(@ie.read(@ie_directory)).to eq @result
      end

      it "should read rows" do
        expect(@ie.rows(@ie_directory)).to eq @result
      end

      it "should create links" do
        links = @ie.links(@ie_directory)
        expect(links.first.url).to         eq @result.first[0]
        expect(links.first.name).to        eq @result.first[1]
        expect(links.first.description).to eq @result.first[2]
        expect(links.first.tag).to         eq @result.first[3]
      end
    end

    describe "Chrome" do

      before do
        @gc_bookmarks = File.join(File.dirname(__FILE__), 'gc/Bookmarks')
        @gc = Chrome.new
      end

      it "should import bookmarks" do
        bookmarks = @gc.read(@gc_bookmarks)
        expect(bookmarks["checksum"]).not_to be_nil
        expect(bookmarks["roots"]).not_to    be_nil
        expect(bookmarks["version"]).not_to  be_nil
      end

      it "should read rows" do
        # expect(@gc.rows(@gc_bookmarks)).to eq @gc_result
      end

      it "should create links"
    end

  end

end
