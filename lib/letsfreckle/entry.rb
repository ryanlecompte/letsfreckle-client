module LetsFreckle
  class Entry < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all(options = {})
      if options[:all_pages]
        collector = []
        page = 1
        while true do
          response = get('entries', {:page => page})
          page+=1
          if response.empty?
            return collector
          else
            collector.concat response
          end
        end
      end
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
      page = options.delete(:page)
      get('entries', searchable_options_from(options).merge({ page: page }))
    end

    # Creates a new entry. Supported options are:
    #  :minutes => '4h' (required)
    #  :project_id => 3221
    #  :description => 'new task'
    #  :date => '2011-08-01'
    def self.create(options = {})
      raise ArgumentError, ':username config missing' unless LetsFreckle.config.username
      raise ArgumentError, ':minutes missing' unless options.has_key?(:minutes)
      post('entries', options.merge(:root => :entry, :user => LetsFreckle.config.username))
    end

    def self.searchable_options_from(options = {})
      options.each_with_object({}) do |(key, value), result|
        result["search[#{key}]"] = Array(value).map(&:to_s).join(',')
      end
    end
  end
end