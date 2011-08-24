module LetsFreckle
  class Tag < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      get('tags')
    end

    def entries
      Entry.find(:tags => [id])
    end
  end
end
