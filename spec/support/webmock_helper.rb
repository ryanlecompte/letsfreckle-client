module WebMockHelper
  def load_response(resource)
    File.read(File.join(File.dirname(__FILE__), '/../responses', "#{resource}.xml.response"))
  end

  def url_for_resource(resource)
    "#{LetsFreckle::Entry.base_api_url}#{LetsFreckle::Entry.relative_path_for(resource)}"
  end

  def stub_api_request(resource)
    stub_http_request(:get, url_for_resource(resource)).
        with(:headers => { 'Accept'         =>'*/*',
                           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                           'User-Agent'     =>'Ruby' }).
        to_return(:body => load_response(resource))
  end
end
