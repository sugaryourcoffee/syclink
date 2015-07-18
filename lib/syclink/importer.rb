require_relative 'link'

# Module that creates a link list and generates an html representation
module SycLink

  # To be subclassed for link importers.
  class Importer
    
    # Path to bookmarks file
    attr_accessor :path
    # Options for importing
    attr_accessor :opts

    # Creates a new Importer and sets the path to the bookmarks file. Opts may
    # be :level which indicates to which levels tags should be imported.
    def initialize(path_to_bookmarks, opts = {})
      @path = path_to_bookmarks
      @opts = opts
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

    # Extracts the tags from a tag string. If a level is provided during 
    # initialization the level is restricting the count of tags imported based
    # on the level value
    def extract_tags(tag_string)
      if tag_string.empty? || opts[:level] == 0
        ""
      else
        tags = tag_string.first.split('/')
        level = [opts[:level] || tags.size, tags.size].min
        tags[-level..-1].join(',')
      end
    end
  end

end
