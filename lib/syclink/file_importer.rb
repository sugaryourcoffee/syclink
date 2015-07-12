module SycLink

  class FileImporter < Importer

    def read(root_to_files)
      root_dir = File.dirname(root_to_files).scan(/^[^\*|\?]*/).first
      regex = Regexp.new("(?<=#{root_dir}).*")
      Dir.glob(root_to_files).map do |file|
        url = file
        name = File.basename(file)
        description = ""
        tags = extract_tags(File.dirname(file).scan(regex))
        [url, name, description, tags]
      end
    end

  end

end
