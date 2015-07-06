require 'sqlite3'
require_relative 'link'

module SycLink

  class Importer
    
    QUERY_STRING = "select p.url, p.title, b.title, a.content, k.keyword, b_t.title from moz_bookmarks b left outer join moz_keywords k on b.keyword_id = k.id left outer join moz_items_annos a on a.item_id = b.id left outer join moz_bookmarks b_t on b.parent = b_t.id join moz_places p on p.id = b.fk where p.url like 'http%';"

    attr_accessor :import

    def initialize(data = [])
      @import = data
    end

    def read(bookmark_file_path, query_string = QUERY_STRING)
      bookmark_file = Dir.glob(File.expand_path(bookmark_file_path)).shift
      raise "Did not find file #{bookmark_file_path}" unless bookmark_file

      db = SQLite3::Database.new(bookmark_file)

      import = db.execute(query_string)
    end 

    def rows
      import.map do |row|
        a = row[0]; b = row[1]; c = row[2]; d = row[3]; e = row[4]; f = row[5]
        [a, 
         b || c, 
         (d || '').gsub("\n", ' '), 
         [e, f].join(',').gsub(/^,|,$/, '')]
      end
    end

    def links
      rows.map do |row|
        attributes = Link::ATTR
        Link.new(row.shift, Hash[row.each { |v| [attributes.shift, v] }])
      end
    end
  end

end
