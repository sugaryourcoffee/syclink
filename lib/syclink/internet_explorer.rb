require_relative 'importer'

module SycLink

  class InternetExplorer < Importer

    def read(path_to_internet_explorer_bookmarks)
      files = Dir.glob(File.join(path_to_internet_explorer_bookmarks, "**/*"))
      files.map do |file|
        [File.basename(file), File.dirname(file)] unless File.directory? file
      end.compact
    end

    def rows
    end

  end
end
