module Faraday
  class Response
    class VerifyStatus < Response::Middleware
      def on_complete(env)
        status = env[:status].to_i
        case env[:method]
        when :get
          raise LetsFreckle::FetchError.new(status) unless status == 200
        when :post
          raise LetsFreckle::CreateError.new(status) unless status == 201
        end
      end
    end
  end
end


