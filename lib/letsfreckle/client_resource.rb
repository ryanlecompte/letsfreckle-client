module LetsFreckle
  # ClientResource should be extended by resource classes in order to gain
  # access to HTTP methods.
  module ClientResource

    def get(resource, options = {})
      response = client.get do |request|
        request.url relative_path_for(resource), options
      end
      response.body.map { |mash| new(mash) }
    end

    def post(resource, options = {})
      client.post do |request|
        request.url relative_path_for(resource), options
        request.headers['Content-Type'] = 'application/xml'
      end
    end

    def base_api_url
      "https://#{LetsFreckle.config.account_host}.letsfreckle.com"
    end

    def relative_path_for(resource)
      "/api/#{resource}.xml?token=#{LetsFreckle.config.token}"
    end

    private

    def client
      Faraday.new(:url => base_api_url) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::FlattenBody
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseXml
        builder.use Faraday::Response::VerifyStatus
        builder.use Faraday::Adapter::NetHttp
      end
    end
  end
end