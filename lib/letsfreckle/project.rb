module LetsFreckle
  class Project < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      get('projects')
    end

    def self.find(project_id)
      get("projects/#{ project_id }", :single => true)
    end

    def entries
      Entry.find(:projects => [id])
    end
  end
end
