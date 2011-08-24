module Faraday
  class Response
    class VerifyStatus < Response::Middleware
      def on_complete(env)
        status = env[:status].to_i
        case env[:method]
        when :get
          raise LetsFreckle::FetchError, "Fetch failed, HTTP error: #{status}" unless status == 200
        when :post
          raise LetsFreckle::CreateError, "Create failed, HTTP error: #{status}" unless status == 201
        end
      end
    end
  end
end


