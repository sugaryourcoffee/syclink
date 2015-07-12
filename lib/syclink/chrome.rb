require "json"

# Module that creates a link list and generates an html representation
module SycLink

  # Importer for Google Chrome links
  class Chrome < Importer

    # Reads the content of the Google Chrome bookmarks file
    def read
      serialized = File.read(path)
      extract_links(JSON.parse(serialized)).flatten.each_slice(4).to_a
    end

    private

    # Extracts the links from the JSON file
    def extract_links(json)
      json["roots"].collect do |key, children|
        extract_children(children["name"], children["children"])
      end
    end

    # Extracts the children from the JSON file
    def extract_children(tag, children)
      children.map do |child|
        if child["children"]
          extract_children("#{tag},#{child['name']}", child["children"])
        else
          [child["url"], child["name"], "", tag]
        end
      end
    end

  end

end
