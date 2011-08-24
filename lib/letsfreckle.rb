require 'delegate'

require 'hashie'
require 'faraday'
require 'faraday_middleware'
require 'faraday/response/flatten_body'
require 'faraday/response/verify_status'

require 'letsfreckle/version'
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
