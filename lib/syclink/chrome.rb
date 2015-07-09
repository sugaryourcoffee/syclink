require "json"

module SycLink

  class Chrome < Importer

    # Reads the content of the Google Chrome bookmarks file
    def read(path_to_bookmarks)
      serialized = File.read(path_to_bookmarks)
      JSON.parse(serialized)
    end
  end

end
