require_relative 'exporter'
require_relative 'formatter'

# Module that creates a link list and generates an html representation
module SycLink
  

  # A Website is organizing a link list. The links can be added, updated and 
  # removed. It is also possible to search for links. And finally an html 
  # representation of the Website can be created.
  class Website

    include Exporter
    include Formatter

    # The links of the website
    attr_reader :links
    # The title of the website
    attr_reader :title

    # Create a new Website
    def initialize(title = "Link List")
      @links = []
      @title = title
    end

    # Add a link to the website
    def add_link(link)
      links << link
    end

    # Remove a link from the website
    def remove_link(link)
      links.delete(link)
    end

    # List links that match the attributes
    def list_links(args = {})
      if args.empty?
        links
      else
        links.select { |link| link.match? args }
      end
    end

    # Finds all links that contain the search string
    def find_links(search)
      links.select { |link| link.contains? search }
    end

    # Merge links based on the provided attribue to one link by combining the 
    # values. The first link will be updated and the obsolete links are deleted
    # and will be returned
    def merge_links_on(attribute, concat_string = ',')
      links_group_by(attribute)
           .select { |key, link_list| links.size > 1 }
           .map do |key, link_list| 
              merge_attributes = Link::ATTRS - [attribute]
              link_list.first
                   .update(Hash[extract_columns(link_list, merge_attributes)
                                .map { |c| c.uniq.join(concat_string) }
                                .collect { |v| [merge_attributes.shift, v] }])
              link_list.shift
              link_list.each { |link| links.delete(link) }
            end
    end

    # Groups the links on the provided attribute
    def links_group_by(attribute)
      links.map      { |link| { key: link.send(attribute), link: link } }
           .group_by { |entry| entry[:key] }
           .each     { |key, link| link.map! { |l| l[:link] }}
    end

    # Create multiple Links based on the attribute provided. The specified 
    # spearator will splitt the attribute value in distinct values and for each
    # different value a Link will be created
    def links_duplicate_on(attribute, separator)
      links.map do  |link|
        link.send(attribute).split(separator).collect do |value|
          link.dup.update(Hash[attribute, value])
        end
      end.flatten
    end

    # Return an array of all link values as rows
    def rows
      links.map { |link| link.row }
    end

    # List all attributes of the links
    def link_attribute_list(attribute)
      links.map { |link| link.send(attribute) }.uniq.sort
    end
  end

end
