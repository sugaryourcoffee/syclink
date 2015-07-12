module SycLink

  class FileImporter < Importer

    def read
      root_dir = File.dirname(path).scan(/^[^\*|\?]*/).first
      regex = Regexp.new("(?<=#{root_dir}).*")
      Dir.glob(path).map do |file|
        url = file
        name = File.basename(file)
        description = ""
        tags = extract_tags(File.dirname(file).scan(regex))
        [url, name, description, tags]
      end
    end

  end

end
