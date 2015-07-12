require 'sqlite3'
require_relative 'importer'

# Module that creates a link list and generates an html representation
module SycLink

  # Importer for Firefox links
  class Firefox < Importer
    
    # Query strig to read links from the Firefox database places.sqlite
    QUERY_STRING = "select p.url, p.title, b.title, a.content, k.keyword, b_t.title from moz_bookmarks b left outer join moz_keywords k on b.keyword_id = k.id left outer join moz_items_annos a on a.item_id = b.id left outer join moz_bookmarks b_t on b.parent = b_t.id join moz_places p on p.id = b.fk where p.url like 'http%';"

    # Reads the links from the Firefox database places.sqlite
    def read
      bookmark_file = Dir.glob(File.expand_path(path)).shift
      raise "Did not find file #{path}" unless bookmark_file

      db = SQLite3::Database.new(path)

      import = db.execute(QUERY_STRING)
    end 

    # Returns row values in Arrays
    def rows
      read.map do |row|
        a = row[0]; b = row[1]; c = row[2]; d = row[3]; e = row[4]; f = row[5]
        [a, 
         b || c, 
         (d || '').gsub("\n", ' '), 
         [e, f].join(',').gsub(/^,|,$/, '')]
      end
    end

  end

end
