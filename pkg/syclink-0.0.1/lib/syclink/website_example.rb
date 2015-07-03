require_relative 'website'
require_relative 'link'

# Module that creates a link list and generates an html representation
module SycLink

  website = SycLink::Website.new("Test")
  links = [ [ "http://sugaryourcoffee.de", 
              {title: "Sugar Your Coffee", tag: "Home"}],
            [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Learning"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Learning"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Learning"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Fun"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Fun"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Challenge"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Challenge"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Challenge"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
             [ "https://github.com", 
              {title: "Github", description: "Repository", tag: "Development"}],
            [ "http://syc.dyndns.org:8080", 
              {title: "Secondhand", description: "Selling", tag: "Home"}],
            [ "http://syc.dyndns.org:8081", 
              {title: "apptrack - application tracking", 
               description: "Application tracking made so easy that is even \
               unbelivable to make it more easy peasy as it is today", 
               tag: "Home"}]]


  links.each do |link| 
    website.add_link(SycLink::Link.new(link[0], link[1]))
  end

  puts website.to_html(File.read("./templates/syclink.html.erb"))
end
