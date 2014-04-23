require 'faraday'

module LetsFreckle
  module UserAgent
    def user_agent
      [ "letsfreckle-client/#{LetsFreckle::VERSION}" ] +
        user_agent_libs + user_agent_ruby
    end

    private

    def user_agent_libs
      [ "faraday/#{Faraday::VERSION}" ]
    end

    def user_agent_ruby
      [ "#{RUBY_ENGINE}/#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}",
        "(#{RUBY_PLATFORM})" ]
    end
  end

  extend UserAgent
  USER_AGENT = self.user_agent.join(" ")
end
