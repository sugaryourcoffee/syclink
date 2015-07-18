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

        # @firefox = Firefox.new(@import)
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
        ie_directory = File.join(File.dirname(__FILE__), 'ie/')
        @result = [ [ "http://www.example.com/", "ie", "", "one" ],
                    [ "http://www.example.com/", "ie", "", "one,two"],
                    [ "http://www.example.com/", "ie", "", "Default"] ]

        @ie = InternetExplorer.new(ie_directory)
      end

      it "should import bookmarks" do
        expect(@ie.read).to eq @result
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

    describe "Chrome" do

      before do
        gc_bookmarks = File.join(File.dirname(__FILE__), 'gc/Bookmarks')

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
        @gc = Chrome.new(gc_bookmarks)
      end

      it "should import bookmarks" do
        expect(@gc.read).to eq @rows_result
      end

      it "should read rows" do
        expect(@gc.rows).to eq @rows_result
      end

      it "should create links" do
        links = @gc.links
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
                       "one.pdf", "", "Default"]]
        @pdf_zero = [["/home/pierre/Work/syclink/spec/syclink/fi/b/three.pdf", 
                       "three.pdf", "", "Default"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/b/a/four.pdf",
                       "four.pdf", "", "Default"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a/two.pdf", 
                       "two.pdf", "", "Default"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/one.pdf", 
                       "one.pdf", "", "Default"]]
        @txt_files = [["/home/pierre/Work/syclink/spec/syclink/fi/a.txt",
                       "a.txt", "", "Default"]]
        @any_files = [["/home/pierre/Work/syclink/spec/syclink/fi/b/three.pdf",
                       "three.pdf", "", "b"],
                      ["/home/pierre/Work/syclink/spec/syclink/fi/b/a/four.pdf",
                       "four.pdf", "", "b,a"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a/two.pdf", 
                       "two.pdf", "", "a"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a.txt", 
                       "a.txt", "", "Default"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/one.pdf", 
                       "one.pdf", "", "Default"], 
                      ["http://www.example.com/", 
                       "ie", "", "c"]]     
        @any_level = [["/home/pierre/Work/syclink/spec/syclink/fi/b/three.pdf",
                       "three.pdf", "", "b"],
                      ["/home/pierre/Work/syclink/spec/syclink/fi/b/a/four.pdf",
                       "four.pdf", "", "a"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a/two.pdf", 
                       "two.pdf", "", "a"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a.txt", 
                       "a.txt", "", "Default"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/one.pdf", 
                       "one.pdf", "", "Default"], 
                      ["http://www.example.com/", 
                       "ie", "", "c"]]     
        @pdf_tags  = [["/home/pierre/Work/syclink/spec/syclink/fi/b/three.pdf",
                       "three.pdf", "", "Prime,Second"],
                      ["/home/pierre/Work/syclink/spec/syclink/fi/b/a/four.pdf",
                       "four.pdf", "", "Prime,Second"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a/two.pdf", 
                       "two.pdf", "", "Prime,Second"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/a.txt", 
                       "a.txt", "", "Prime,Second"], 
                      ["/home/pierre/Work/syclink/spec/syclink/fi/one.pdf", 
                       "one.pdf", "", "Prime,Second"], 
                      ["http://www.example.com/", 
                       "ie", "", "Prime,Second"]]     
      end

      it "should import pdf filenames" do
        fi = FileImporter.new(File.join(@file_dir, "**/*.pdf"))
        expect(fi.read).to eq @pdf_files
      end

      it "should import a fully qualified text-file" do
        fi = FileImporter.new(File.join(@file_dir, "a.txt"))
        expect(fi.read).to eq @txt_files
      end

      it "should import any file" do
        fi = FileImporter.new(File.join(@file_dir, "**/*"))
        expect(fi.read).to eq @any_files
      end

      it "should read rows from pdf" do
        fi = FileImporter.new(File.join(@file_dir, "**/*.pdf"))
        expect(fi.rows).to eq @pdf_files
      end

      it "should create links from pdf" do
        fi = FileImporter.new(File.join(@file_dir, "**/*.pdf"))
        links = fi.links

        expect(links.first.url).to         eq @pdf_files.first[0]
        expect(links.first.name).to        eq @pdf_files.first[1]
        expect(links.first.description).to eq @pdf_files.first[2]
        expect(links.first.tag).to         eq @pdf_files.first[3]
      end

      it "should use only the parent directory as the tag" do
        fi = FileImporter.new(File.join(@file_dir, "**/*"), level: 1)
        expect(fi.read).to eq @any_level
      end

      it "should not import tags" do
        fi = FileImporter.new(File.join(@file_dir, "**/*.pdf"), level: 0)
        expect(fi.read).to eq @pdf_zero
      end

      it "should specify tags during import" do
        fi = FileImporter.new(File.join(@file_dir, "**/*"), 
                              level: 1, tags: "Prime,Second")
        expect(fi.read).to eq @pdf_tags
      end
    end

  end

end
