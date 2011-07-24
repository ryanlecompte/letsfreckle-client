module LetsFreckle
  class Project < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      fetch('projects')
    end

    def initialize(delegate)
      super(delegate)
    end

    def entries
      Entry.find(:projects => [id])
    end
  end
end
