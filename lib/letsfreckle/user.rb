module LetsFreckle
  class User < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      fetch('users')
    end

    def entries
      Entry.find(:people => [id])
    end
  end
end
