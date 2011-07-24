# Ruby's DelegateClass expects the delegate to support the second
# optional argument to Object#respond_to?. Hashie::Mash doesn't
# currently define the method in this way, so we modify it here.
module Hashie
  class Mash
    alias_method :old_respond_to?, :respond_to?

    def respond_to?(sym, include_private=false)
      old_respond_to?(sym)
    end
  end
end