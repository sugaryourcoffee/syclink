require 'syclink/firefox'
require 'syclink/internet_explorer'

module SycLink

  describe Importer do

    describe "should import Firefox bookmarks" do
    
      before do
        @import = [ [ "http://a.com", "a", "at", "a site", nil,  "aa" ],
                    [ "http://b.com", "b", "bt", nil,      "ab", "bb" ],
                    [ "http://c.com", nil, "ct", "b site", "bc", nil  ] ] 
        
        @result = [ [ "http://a.com", "a",  "a site", "aa"    ],
                    [ "http://b.com", "b",  "",       "ab,bb" ],
                    [ "http://c.com", "ct", "b site", "bc"    ] ]

        @firefox = Firefox.new(@import)
      end

      it "and create rows" do
        expect(@firefox.rows).to eq  @result
      end
      
      it "and create links" do
        links = @firefox.links
        expect(links.first.url).to         eq @result.first[0]
        expect(links.first.name).to        eq @result.first[1]
        expect(links.first.description).to eq @result.first[2]
        expect(links.first.tag).to         eq @result.first[3]
      end

    end

    describe "Internet Explorer" do

      before do
        @ie_directory = File.join(File.dirname(__FILE__), 'ie/')
        @result = [ [ "http://example.com", "ie", "", "" ],
                    [ "http://example.com", "ie", "", "one"],
                    [ "http://example.com", "ie", "", "one,two"] ]

        @ie = InternetExplorer.new
      end

      it "should import bookmarks" do
        expect(@ie.read(@ie_directory)).to eq @result
      end

      it "should read rows" do
        expect(@ie.rows).to eq @result
      end

      it "should create links" do
        links = @ie.links
        expect(links.first.url).to         eq @result.first[0]
        expect(links.first.name).to        eq @result.first[1]
        expect(links.first.description).to eq @result.first[2]
        expect(links.first.tag).to         eq @result.first[3]
      end
    end

    describe "should import Chrome bookmarks" do
      it "should import Chrome bookmarks"
    end

  end

end
