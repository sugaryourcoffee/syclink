require_relative 'link'

# Module that creates a link list and generates an html representation
module SycLink

  # To be subclassed for link importers.
  class Importer
    
    # Raw data of imported links
    attr_accessor :import

    # Optionally loading raw data
    def initialize(data = [])
      @import = data
    end

    # To be overridden! 
    # Read the raw data from the bookmarks file.
    def read(bookmark_file_path)
      raise NotImplementedError
    end 

    # Links values returned in an Array. Default implementation returns values
    # from #read.
    def rows
      import
    end

    # Links returned as Link objects
    def links
      rows.map do |row|
        attributes = Link::ATTRS.dup - [:url]
        Link.new(row.shift, Hash[row.map { |v| [attributes.shift, v] }])
      end
    end
  end

end
