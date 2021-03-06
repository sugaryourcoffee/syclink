require 'uri'

# Module that creates a link list and generates an html representation
module SycLink

  # Methods to check links for availability. A link may be an URI or a file
  module LinkChecker

    # Checks whether a link is reachable. If so code '200' is returned
    # otherwise 'Error'
    # #response expects that the including class has an attribute 'url'
    def response
      return "Error" unless url
      uri = to_uri(url)
      uri ? response_of_uri(uri) : response_of_file(url)
    end

    # Checks whether the uri is reachable. If so it returns '200' otherwise
    # 'Error'. uri has to have a host, that is uri.host should not be nil
    def response_of_uri(uri)
      begin
        Net::HTTP.start(uri.host, uri.port) do |http|
          http.head(uri.path.size > 0 ? uri.path : "/").code
        end
      rescue Exception => e
        "Error"
      end
    end

    # Checks whether a file exists. If so it returns '200' otherwise
    # 'error'
    def response_of_file(file)
      File.exists?(file) ? "200" : "Error"
    end

    # Transforms an URL (String) to an URI. If URL is not valid false is 
    # returned
    def to_uri(url)
      uri = URI.parse(url)
      uri.host.nil? ? false : uri
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end
  end

end
