require_relative 'designer'

# Module that creates a link list and generates an html representation
module SycLink
  designer = Designer.new
  designer.new_website("SYC LINK")
  designer.add_links_from_file("./templates/links")
  designer.create_website("./templates", "./templates/syclink.html.erb")
end
