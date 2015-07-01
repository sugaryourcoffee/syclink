module SycLink

  class Link

    ATTRS = [:url, :name, :description, :tag]

    attr_accessor *ATTRS

    def initialize(url, params = {})
      @url         = url
      params       = defaults(url).merge(params)
      @name        = params[:name]
      @description = params[:description]
      @tag         = params[:tag]
    end

    def update(args)
      select_defined(args).each do |attribute, value|
        send("#{attribute}=", value)
      end
    end

    def match?(args)
      select_defined(args).reduce(true) do |sum, attribute|
        sum = sum && (send(attribute[0]) == attribute[1])
      end 
    end

    def contains?(search)
      search = search.delete(' ')
      target = instance_variables.map { |v| instance_variable_get v }.join
      target.downcase.delete(' ').scan(search).size > 0
    end

    private

    def defaults(url)
      { name: url, description: "", tag: "untagged" }
    end

    def select_defined(args)
      args.select { |k, v| (ATTRS.include? k) && !v.nil? }
    end
  end

end
