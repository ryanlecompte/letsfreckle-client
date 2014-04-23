module WebMockHelper
  def load_response(resource, options = {})
    File.read(File.join(File.dirname(__FILE__), '/../responses', "#{resource}#{!options[:page] ? '' : options[:page]}.xml.response"))
  end

  def url_for_resource(resource, options = {})
    "#{LetsFreckle::Entry.base_api_url}#{LetsFreckle::Entry.relative_path_for(resource, options[:page])}"
  end

  def headers_for_response(resource, options = {})
    if resource == 'entries' && options[:page] && options[:page] == 1
      return {'Link' => "<#{LetsFreckle::Entry.base_api_url}/api/entries.json?page=#{!options[:page] ? 0 : (options[:page] + 1)}&per_page=100>; rel=\"next\""}
    end
    {}
  end

  def stub_api_request(resource, options = {})
    stub_http_request(:get, url_for_resource(resource, options)).
        with(:headers => {
          'Accept'         =>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'     => LetsFreckle::USER_AGENT
        }).
        to_return(:body => load_response(resource, options), :headers => headers_for_response(resource))
  end
end
