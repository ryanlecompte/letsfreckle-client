module LetsFreckle
  class Tag < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      fetch('tags')
    end

    def initialize(delegate)
      super(delegate)
    end

    def entries
      Entry.find(:tags => [id])
    end
  end
end
