require 'syclink/firefox'
require 'syclink/chrome'
require 'syclink/internet_explorer'
require 'syclink/file_importer'

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

        @rows_result = [["http://syc.dyndns.org:8080/",
                         "Secondhand | Home",
                         "",
                         "Bookmarks bar"],
                        ["http://syc.dyndns.org:8081/",
                         "Apptrack | Home",
                         "",
                         "Other bookmarks"],
                        ["http://bestgems.org/gems/sycsvpro",
                         "sycsvpro -- BestGems",
                         "",
                         "Other bookmarks,Gems"],
                        ["https://rubygems.org/profiles/sugaryourcoffee",
                         "RubyGems.org | your community gem host",
                         "",
                         "Other bookmarks,Gems"]]
        @gc = Chrome.new
      end

      it "should import bookmarks" do
        expect(@gc.read(@gc_bookmarks)).to eq @rows_result
      end

      it "should read rows" do
        expect(@gc.rows(@gc_bookmarks)).to eq @rows_result
      end

      it "should create links" do
        links = @gc.links(@gc_bookmarks)
        expect(links.first.url).to         eq @rows_result.first[0]
        expect(links.first.name).to        eq @rows_result.first[1]
        expect(links.first.description).to eq @rows_result.first[2]
        expect(links.first.tag).to         eq @rows_result.first[3]
      end
    end

    describe "File" do

      before do
        @file_dir = File.join(File.dirname(__FILE__), 'fi/')
        @pdf_files = [["/home/pierre/Work/syclink/spec/syclink/fi/b/three.pdf", 
                       "three.pdf", "", "b"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/b/a/four.pdf",
                       "four.pdf", "", "b,a"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a/two.pdf", 
                       "two.pdf", "", "a"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/one.pdf", 
                       "one.pdf", "", ""]]
        @txt_files = [["/home/pierre/Work/syclink/spec/syclink/fi/a.txt",
                       "a.txt", "", ""]]
        @fi = FileImporter.new
      end

      it "should import pdf filenames" do
        expect(@fi.read(File.join(@file_dir, "**/*.pdf"))).to eq @pdf_files
      end

      it "should import a fully qualified text-file" do
        expect(@fi.read(File.join(@file_dir, "a.txt"))).to eq @txt_files
      end

      it "should read rows" do
        expect(@fi.rows(File.join(@file_dir, "**/*.pdf"))).to eq @pdf_files
      end

      it "should create links" do
        links = @fi.links(File.join(@file_dir, "**/*.pdf"))

        expect(links.first.url).to         eq @pdf_files.first[0]
        expect(links.first.name).to        eq @pdf_files.first[1]
        expect(links.first.description).to eq @pdf_files.first[2]
        expect(links.first.tag).to         eq @pdf_files.first[3]
      end
    end

  end

end
