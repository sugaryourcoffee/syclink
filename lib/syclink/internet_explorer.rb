require_relative 'importer'

# Module that creates a link list and generates an html representation
module SycLink

  # Importer for Internet Explorer
  class InternetExplorer < Importer

    # Reads the links from the Internet Explorer's bookmarks directory
    def read
      files = Dir.glob(File.join(path, "**/*"))
      
      regex = Regexp.new("(?<=#{path}).*")

      files.map do |file|
        unless ((File.directory? file) || (File.extname(file).upcase != ".URL"))
          url = File.read(file).scan(/(?<=\nURL=)(.*)$/).flatten.first.chomp
          name = url_name(File.basename(file, ".*"))
          description = ""
          tag         = extract_tags(File.dirname(file).scan(regex))
          [url, name, description, tag]
        end
      end.compact
    end

  end
end
