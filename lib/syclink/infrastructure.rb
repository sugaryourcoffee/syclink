module SycLink

  module Infrastructure

    # Creates the filename of the website for saving, loading and deleting
    def yaml_file(directory = '.', website)
      File.join(directory, "#{website.downcase.gsub(/\s/, '-')}.website")
    end
    
    # Creates an html filename to save the html representation of the website
    # to
    def html_file(directory = '.', website)
      File.join(directory, "{website.downcase.gsub(/\s/, '-')}.html")
    end

  end

end
