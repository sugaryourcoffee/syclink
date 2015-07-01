require_relative 'website'
require_relative 'link'
require_relative 'infrastructure'
require 'yaml'

module SycLink

  # Creates a designer that acts as a proxy between the user and the website.
  # The designer will create a website with the provided title.
  class Designer

    include Infrastructure

    # The website the designer is working on
    attr_accessor :website

    # Creates a new website where designer can operate on
    def new_website(title = "SYC LINK")
      @website = Website.new(title)
    end

    # Adds a link based on the provided arguments to the website
    def add_link(url, args = {})
      website.add_link(Link.new(url, args))
    end

    # Reads arguments from a CSV file and creates links accordingly. The links
    # are added to the websie
    def add_links_from_file(file)
      File.foreach(file) do |line|
        url, title, description, tag = line.split(';')
        website.add_link(Link.new(url, { title: title,
                                         description: description,
                                         tag: tag }))
      end
    end

    # Finds links based on a search string
    def find_links(search)
      website.find_links(search)
    end

    # Updates a link. The link is identified by the URL. If there is more than
    # one link with the same URL, only the first link is updated
    def update_link(url, args)
      website.find_links(url).first.update(args)
    end

    # Saves the website to the specified directory with the downcased name of
    # the website and the extension 'website'. The website is save as YAML
    def save_website(directory)
      File.open(yaml_file(directory, website.title), 'w') do |f|
        YAML.dump(website, f)
      end
    end

    # Loads a website based on the provided YAML-file and asigns it to the
    # designer to operate on
    def load_website(website)
      @website = YAML.load_file(website)
    end

    # Deletes the website if it already exists
    def delete_website(directory)
      if File.exists? yaml_file(directory, website.title)
        FileUtils.rm(yaml_file(directory, website.title)) 
      end
    end

    # Creates the html representation of the website. The website is saved to
    # the directory with websites title and needs an erb-template where the
    # links are integrated to. An example template can be found at
    # templates/syclink.html.erb
    def create_website(directory, template_filename)
      template = File.read(template_filename)
      File.open(html_file(directory), 'w') do |f|
        f.puts website.to_html(template)
      end 
    end
 
  end

end
