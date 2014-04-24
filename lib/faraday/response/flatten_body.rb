module Faraday
  class Response
    # FlattenBody is a middleware that flattens the response body, and also extends
    # Hashie::Mash instances with a module that allows them to work properly with DelegateClass.
    class FlattenBody < Response::Middleware
      dependency 'hashie/mash'

      def parse(body)
        return body unless body.respond_to?(:to_a)
        flattened_response = body.to_a.flatten
        flattened_response.delete_if { |item| !(::Hashie::Mash === item) }
        flattened_response.map do |mash|
          # extend so that #respond_to? works nicely with DelegateClass
          mash.extend(LetsFreckle::Extensions::Mash)
        end
      end
    end
  end
end