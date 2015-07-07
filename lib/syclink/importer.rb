require_relative 'link'

module SycLink

  class Importer
    
    attr_accessor :import

    def initialize(data = [])
      @import = data
    end

    def read(bookmark_file_path)
      raise NotImplementedError
    end 

    def rows
      raise NotImplementedError
    end

    def links
      rows.map do |row|
        attributes = Link::ATTR
        Link.new(row.shift, Hash[row.each { |v| [attributes.shift, v] }])
      end
    end
  end

end
