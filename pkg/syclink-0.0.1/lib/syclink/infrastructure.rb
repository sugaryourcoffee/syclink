# Module that creates a link list and generates an html representation
module SycLink

  # Helper methods to setup the infrastructure for syclink
  module Infrastructure

    # Creates a directory if it does not exist
    def create_directory_if_missing(directory)
      unless File.exists? directory
        Dir.mkdir directory
      end
    end

    # Copies a file to a target directory
    def copy_file_if_missing(file, to_directory)
      unless File.exists? File.join(to_directory, File.basename(file))
        FileUtils.cp(file, to_directory)
      end
    end

    # Loads the configuration from a file
    def load_config(file)
      unless File.exists? file
        File.open(file, 'w') do |f| 
          YAML.dump({ default_website: 'default' }, f) 
        end
      end
      YAML.load_file(file)
    end

    # Creates the filename of the website for saving, loading and deleting
    def yaml_file(directory = '.', website)
      File.join(directory, "#{website.downcase.gsub(/\s/, '-')}.website")
    end
    
    # Creates an html filename to save the html representation of the website
    # to
    def html_file(directory = '.', website)
      File.join(directory, "#{website.downcase.gsub(/\s/, '-')}.html")
    end

  end

end
