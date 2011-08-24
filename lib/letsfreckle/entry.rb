module LetsFreckle
  class Entry < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      get('entries')
    end

    # Fetches all entries. Supported options are:
    #  :people => ['ryan', 'frank']
    #  :projects => ['project1', 'project2']
    #  :tags => ['tag1', 'tag2']
    #  :from => '2011-01-01'
    #  :to => '2012-01-01'
    #  :billable => true/false
    def self.find(options = {})
      get('entries', searchable_options_from(options))
    end

    # Creates a new entry. Supported options are:
    #  :minutes => '4h' (required)
    #  :project_id => 3221
    #  :description => 'new task'
    #  :date => '2011-08-01'
    def self.create(options = {})
      raise ArgumentError, ':username config missing' unless LetsFreckle.config.username
      raise ArgumentError, ':minutes missing' unless options.has_key?(:minutes)
      post('entries', :entry => options.merge(:user => LetsFreckle.config.username))
    end

    def self.searchable_options_from(options = {})
      options.each_with_object({}) do |(key, value), result|
        case value
        when Array then
          result["search[#{key}]"] = value.join(',')
        else
          result["search[#{key}]"] = value.to_s
        end
      end
    end
  end
end