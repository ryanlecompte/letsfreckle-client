module LetsFreckle
  class Project < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      get('projects')
    end

    def entries
      Entry.find(:projects => [id])
    end
  end
end
