require 'erb'

module SycLink

  module Exporter

    def to_html(template)
      renderer = ERB.new(template)
      renderer.result(binding)
    end

  end

end
