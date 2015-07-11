require "json"

module SycLink

  class Chrome < Importer

    # Reads the content of the Google Chrome bookmarks file
    def read(path_to_bookmarks)
      serialized = File.read(path_to_bookmarks)
      extract_links(JSON.parse(serialized))
    end

    private

    def extract_links(json)
      json["roots"].collect do |key, children|
        [children["name"], extract_children(children["children"])]
      end
    end

    def extract_children(children)
      children.map do |child|
        if child["children"]
          [child["name"], extract_children(child["children"])]
        else
          [child["name"], child["url"]]
        end
      end
    end

  end

end
