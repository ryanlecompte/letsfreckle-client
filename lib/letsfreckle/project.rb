module LetsFreckle
  class Project < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      get('projects')
    end

    def self.find(project_id)
      get("projects/#{ project_id }", :single => true)
    end

    # Creates a new project. Supported options are:
    #  :name => 'Pet Project' (required)
    def self.create(options = {})
      raise ArgumentError, ':name missing' unless options.has_key?(:name)
      post('projects', options.merge(:root => :project))
    end

    def entries
      Entry.find(:projects => [id])
    end
  end
end
