module Faraday
  class Request
    class XML < Faraday::Middleware
      dependency 'active_support/all'

      def initialize(app, options={})
        @app     = app
        @options = options
      end

      def call(env)
        if env[:method] == :post
          env[:body] = env[:body].to_xml(:root => env[:body].delete(:root))
        end

        @app.call(env)
      end
    end
  end
end