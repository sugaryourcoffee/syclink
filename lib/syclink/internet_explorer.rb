require_relative 'importer'

# Module that creates a link list and generates an html representation
module SycLink

  # Importer for Internet Explorer
  class InternetExplorer < Importer

    # Reads the links from the Internet Explorer's bookmarks directory
    def read(path_to_internet_explorer_bookmarks)
      files = Dir.glob(File.join(path_to_internet_explorer_bookmarks, "**/*"))
      
      regex = Regexp.new("(?<=#{path_to_internet_explorer_bookmarks}).*")

      files.map do |file|
        unless File.directory? file
          url = File.read(file).scan(/(?<=\nURL=)(.*)$/).flatten.first
          name = File.basename(file)
          description = ""
          tag         = extract_tags(File.dirname(file).scan(regex))
          [url, name, description, tag]
        end
      end.compact
    end

  end
end
