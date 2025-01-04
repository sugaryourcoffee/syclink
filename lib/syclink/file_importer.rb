module SycLink

  class FileImporter < Importer

    GLOB_PATTERN = /^[^\*\?\[\]\{\}]*/

    def read
      regex = Regexp.new("(?<=#{root_dir(path)}).*")
      files(path).map do |file|
        next if File.directory? file
        url, name = if File.extname(file).upcase == ".URL"
                      begin
                        [File.read(file).scan(/(?<=\nURL=)(.*)$/)
                                        .flatten.first.chomp,
                         url_name(File.basename(file, ".*"))]
                      rescue
                        [file, File.basename(file)]
                      end
                    else
                      [file, File.basename(file)]
                    end
        description = ""
        tags = extract_tags(File.dirname(file).scan(regex))
        [url, name, description, tags]
      end.compact
    end

    private

    def files(path)
      if path.is_a?(String)
        Dir.glob(expand_to_glob(path))
      elsif path.is_a?(Array)
        path.size > 1 ? path : Dir.glob(expand_to_glob(path.first))
      else
        abort "Path #{path} is not a valid path"
      end
    end

    def expand_to_glob(path)
      File.directory?(path) ? File.expand_path("*", path) : path
    end

    def root_dir(path)
      if path.is_a?(String) 
        path 
      else 
        File.dirname(path.first)
      end.scan(GLOB_PATTERN).first
    end
  end

end
