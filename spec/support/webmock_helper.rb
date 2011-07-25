module WebMockHelper
  def load_response(resource)
    File.read(File.join(File.dirname(__FILE__), '/../responses', "#{resource}.xml.response"))
  end
end