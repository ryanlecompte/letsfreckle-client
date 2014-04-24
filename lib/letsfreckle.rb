require 'delegate'

require 'hashie'
require 'faraday'
require 'faraday_middleware'
require 'faraday/request/xml'
require 'faraday/request/user_agent'
require 'faraday/response/flatten_body'
require 'faraday/response/parse_xml_yaml_allowed'
require 'faraday/response/verify_status'

Faraday::Request.register_middleware \
  :user_agent => lambda { Faraday::Request::UserAgent },
  :xml        => lambda { Faraday::Request::XML }

Faraday::Response.register_middleware \
  :flatten_body     => lambda { Faraday::Response::FlattenBody },
  :verify_status    => lambda { Faraday::Response::VerifyStatus },
  :xml_yaml_allowed => lambda { Faraday::Response::ParseXml::YamlAllowed }

require 'letsfreckle/version'
require 'letsfreckle/user_agent'
require 'letsfreckle/extensions/mash'
require 'letsfreckle/configuration'
require 'letsfreckle/client_resource'
require 'letsfreckle/project'
require 'letsfreckle/error'
require 'letsfreckle/entry'
require 'letsfreckle/user'
require 'letsfreckle/tag'

module LetsFreckle
  extend self

  attr_reader :config

  def configure(&block)
    raise ArgumentError, 'configuration block required' unless block
    @config = Configuration.new
    @config.instance_eval(&block)
  end
end
