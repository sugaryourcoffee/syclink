require 'syclink/importer'

module SycLink

  describe Importer do

    describe "should import Firefox bookmarks" do
    
      before do
        @import = [ [ "http://a.com", "a", "at", "a site", nil,  "aa" ],
                    [ "http://b.com", "b", "bt", nil,      "ab", "bb" ],
                    [ "http://c.com", nil, "ct", "b site", "bc", nil  ] ] 
        @firefox = Importer.new(@import)
      end

      it "and create rows" do
        result = [ [ "http://a.com", "a",  "a site", "aa"    ],
                   [ "http://b.com", "b",  "",       "ab,bb" ],
                   [ "http://c.com", "ct", "b site", "bc"    ] ]
        expect(@firefox.rows).to eq  result
      end
      
      it "and create links"

    end

    it "should import Internet Explorer bookmarks"

    it "should import Chrome bookmarks"

  end

end
