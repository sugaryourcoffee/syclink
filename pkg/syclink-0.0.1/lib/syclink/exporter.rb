require 'erb'

# Module that creates a link list and generates an html representation
module SycLink

  # Methods to export data into specific formats
  module Exporter

    # Creates an html file based on an erb template
    def to_html(template)
      renderer = ERB.new(template)
      renderer.result(binding)
    end

  end

end
