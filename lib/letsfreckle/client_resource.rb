module LetsFreckle
  # ClientResource should be extended by resource classes in order to gain
  # access to HTTP methods.
  module ClientResource
    API_URL = "https://%s.letsfreckle.com/api/%s.xml?token=%s"

    def fetch(resource, options = {})
      response = HTTParty.get(url(resource), :query => options)
      verify!(response, 200) { raise FetchError, "Fetch failed, HTTP error: #{response.code}" }
      mashes = mashes_from_response(response)
      mashes.map { |m| new(m) }
    end

    def post(resource, options = {})
      response = HTTParty.post(url(resource), :body => options)
      verify!(response, 201) { raise CreateError, "Create failed, HTTP error: #{response.code}" }
    end

    private

    def url(resource)
      API_URL % [LetsFreckle.config.account, resource, LetsFreckle.config.token]
    end

    def verify!(response, code, &block)
      block.call unless response.code == code
    end

    def mashes_from_response(response)
      flattened_response = response.to_a.flatten
      flattened_response.keep_if { |r| r.is_a?(Hash) }
      flattened_response.map { |h| Hashie::Mash.new(h) }
    end
  end
end