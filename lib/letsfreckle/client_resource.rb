module LetsFreckle
  # ClientResource should be extended by resource classes in order to gain
  # access to HTTP methods.
  module ClientResource

    def get(resource, options = {})
      get_single = options.delete(:single)

      response = client.get do |request|
        request.url relative_path_for(resource), options
      end

      if get_single
        new(response.body.first)
      else
        response.body.map { |mash| new(mash) }
      end
    end

    def post(resource, options = {})
      client.post do |request|
        request.url relative_path_for(resource)
        request.headers['Content-Type'] = 'application/xml'
        request.body = options
      end
    end

    def base_api_url
      "https://#{LetsFreckle.config.account_host}.letsfreckle.com"
    end

    def relative_path_for(resource, page = nil)
      "/api/#{resource}.xml?page=#{page.nil? ? 1 : page}&token=#{LetsFreckle.config.token}"
    end

    private

    def client
      Faraday.new(:url => base_api_url) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Request::XML
        builder.use Faraday::Request::UserAgent, LetsFreckle::USER_AGENT
        builder.use Faraday::Response::FlattenBody
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseXml::YamlAllowed
        builder.use Faraday::Response::VerifyStatus
        builder.use Faraday::Adapter::NetHttp
      end
    end
  end
end
