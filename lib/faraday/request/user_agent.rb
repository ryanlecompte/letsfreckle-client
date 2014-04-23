module Faraday
  class Request
    class UserAgent < Faraday::Middleware
      HEADER = "User-Agent".freeze

      def initialize(app, user_agent, options={})
        @app        = app
        @user_agent = user_agent
        @options    = options
      end

      def call(env)
        env[:request_headers][HEADER] = @user_agent

        @app.call(env)
      end
    end
  end
end
