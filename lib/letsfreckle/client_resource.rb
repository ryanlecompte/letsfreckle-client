module LetsFreckle
  # ClientResource should be extended by resource classes in order to gain
  # access to HTTP methods.
  module ClientResource
    API_URL = "https://%s.letsfreckle.com/api/%s.xml?token=%s"

    def fetch(resource, options = {})
      response = HTTParty.get(url(resource), :query => options, :format => :xml)
      verify!(response, 200) { raise FetchError, "Fetch failed, HTTP error: #{response.code}" }
      mashes = mashes_from_response(response)
      mashes.map { |m| new(m) }
    end

    def post(resource, options = {})
      response = HTTParty.post(url(resource), :body => options, :format => :xml)
      verify!(response, 201) { raise CreateError, "Create failed, HTTP error: #{response.code}" }
    end

    def url(resource)
      API_URL % [LetsFreckle.config.account_host, resource, LetsFreckle.config.token]
    end

    private

    def verify!(response, code, &block)
      block.call unless response.code == code
    end

    def mashes_from_response(response)
      return [] unless response.respond_to?(:to_a)
      flattened_response = response.to_a.flatten
      flattened_response.keep_if { |r| r.is_a?(Hash) }
      flattened_response.map do |h|
        m = Hashie::Mash.new(h)
        # extend so that #respond_to? works nicely with DelegateClass
        m.extend(Extensions::Mash)
      end
    end
  end
end