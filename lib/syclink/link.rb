module SycLink

  class Link

    attr_accessor :url, :title, :description, :tag

    def initialize(url, params = {})
      @url         = url
      params       = defaults(url).merge(params)
      @title       = params[:title]
      @description = params[:description]
      @tag         = params[:tag]
    end

    def update(args)
      args.each do |attribute, value|
        send("#{attribute}=", value)
      end
    end

    def match?(args)
      args.reduce(true) do |sum, attribute|
        p attribute
        p sum
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
      { title: url, description: "", tag: "untagged" }
    end
  end

end
