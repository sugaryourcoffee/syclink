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

    # Takes an array of row values and converts them to a csv string. Expects
    # that the importing class is having a method rows.
    def to_csv
      rows.map { |row| row.join(';') }.join("\n")
    end

  end

end
