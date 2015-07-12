require_relative 'link'

# Module that creates a link list and generates an html representation
module SycLink

  # To be subclassed for link importers.
  class Importer
    
    # Path to bookmarks file
    attr_accessor :path

    # Creates a new Importer and sets the path to the bookmarks file
    def initialize(path_to_bookmarks)
      @path = path_to_bookmarks
    end

    # To be overridden! 
    # Read the raw data from the bookmarks file. The bookmarks file has to be
    # provided during initialization with #initialize
    def read
      raise NotImplementedError
    end 

    # Links values returned in an Array. Default implementation returns values
    # from #read.
    def rows
      read
    end

    # Links returned as Link objects
    def links
      rows.map do |row|
        attributes = Link::ATTRS.dup - [:url]
        Link.new(row.shift, Hash[row.map { |v| [attributes.shift, v] }])
      end
    end

    protected

    def extract_tags(tag_string)
      if tag_string.empty?
        ""
      else
        tag_string.first.gsub("/", ",")
      end
    end
  end

end
