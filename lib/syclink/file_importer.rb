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
        Dir.glob(path)
      elsif path.is_a?(Array)
        path.size > 1 ? path : Dir.glob(path.first)
      else
        abort "Path #{path} is not a valid path"
      end
    end

    def root_dir(path)
      path = if path.is_a?(String) 
               path 
             else 
               path.first
             end.scan(GLOB_PATTERN).first

      File.directory?(path) ? path : File.dirname(path)
    end
  end

end
