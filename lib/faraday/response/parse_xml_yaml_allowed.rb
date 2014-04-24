require 'multi_xml'
require 'faraday_middleware/response/parse_xml'

class Faraday::Response::ParseXml
  def self.allow_yaml
    disallowed_types = MultiXml::DISALLOWED_XML_TYPES - %w[ yaml ]

    klass = Class.new(self)
    klass.define_parser do |body|
      ::MultiXml.parse(body, :disallowed_types => disallowed_types)
    end
    klass
  end

  class YamlAllowed < self
    DISALLOWED_XML_TYPES = MultiXml::DISALLOWED_XML_TYPES - %w[ yaml ]
    define_parser do |body|
      ::MultiXml.parse(body, :disallowed_types => DISALLOWED_XML_TYPES)
    end
  end
end
