# Ruby's DelegateClass expects the delegate to support the second
# optional argument to Object#respond_to?. Hashie::Mash doesn't
# currently define the method in this way, so we provide a module
# that is #extend'ed into each Hashie::Mash instance that we create.
module LetsFreckle
  module Extensions
    module Mash
      def respond_to?(sym, include_private=false)
        super(sym)
      end
    end
  end
end