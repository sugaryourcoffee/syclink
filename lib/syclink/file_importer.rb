module SycLink

  class FileImporter < Importer

    def read
      root_dir = File.dirname(path).scan(/^[^\*|\?]*/).first
      regex = Regexp.new("(?<=#{root_dir}).*")
      Dir.glob(path).map do |file|
        next if File.directory? file
        url, name = if File.extname(file).upcase == ".URL"
                      [File.read(file).scan(/(?<=\nURL=)(.*)$/).flatten.first,
                       name = File.basename(file, ".*")]
                    else
                      [file, File.basename(file)]
                    end
        description = ""
        tags = extract_tags(File.dirname(file).scan(regex))
        [url, name, description, tags]
      end.compact
    end

  end

end
