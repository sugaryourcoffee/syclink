# Module that creates a link list and generates an html representation
module SycLink

  # Creates a link with url, name, description and tag
  class Link

    # Attributes that are accessible
    ATTRS = [:url, :name, :description, :tag]

    # Attribute accessors generated from ATTRS
    attr_accessor *ATTRS

    # Create a new link with url and params. If params are not provided 
    # defaults are used for name the url is used, description is empty and
    # tag is set to 'untagged'
    def initialize(url, params = {})
      @url         = url
      params       = defaults(url).merge(select_defined(params))
      @name        = params[:name]
      @description = params[:description]
      @tag         = params[:tag]
    end

    # Updates the attributes of the link specified by args and returns the
    # updated link
    def update(args)
      select_defined(args).each do |attribute, value|
        send("#{attribute}=", value)
      end
      self
    end

    # Checks whether the link matches the values provided by args and returns
    # true if so otherwise false
    def match?(args)
      select_defined(args).reduce(true) do |sum, attribute|
        sum = sum && (send(attribute[0]) == attribute[1])
      end 
    end

    # Checks whether the search string is contained in one or more of the
    # attributes. If the search string is found true is returned otherwise
    # false
    def contains?(search)
      search = search.delete(' ').downcase
      target = instance_variables.map { |v| instance_variable_get v }.join
      target.downcase.delete(' ').scan(search).size > 0
    end

    # Return the values of the link in an array
    def row
      [ url, name, description, tag ]
    end

    private

    # Specifies the default values
    def defaults(url)
      { name: url, description: "", tag: "untagged" }
    end

    # Based on the ATTRS the args are returned that are included in the ATTRS.
    # args with nil values are omitted
    def select_defined(args)
      args.select { |k, v| (ATTRS.include? k) && !v.nil? }
    end
  end

end
