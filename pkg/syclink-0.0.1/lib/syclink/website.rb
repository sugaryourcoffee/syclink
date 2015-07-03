require_relative 'exporter'

# Module that creates a link list and generates an html representation
module SycLink
  

  # A Website is organizing a link list. The links can be added, updated and 
  # removed. It is also possible to search for links. And finally an html 
  # representation of the Website can be created.
  class Website

    include Exporter

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

    # Groups the links on the provided attribute
    def links_group_by(attribute)
      links.map      { |link| { key: link.send(attribute), link: link } }
           .group_by { |entry| entry[:key] }
           .each     { |key, link| link.map! { |l| l[:link] }}
    end

    # List all attributes of the links
    def link_attribute_list(attribute)
      links.map { |link| link.send(attribute) }.uniq.sort
    end
  end

end