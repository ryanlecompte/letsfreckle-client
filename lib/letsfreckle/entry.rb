module LetsFreckle
  class Entry < DelegateClass(Hashie::Mash)
    extend ClientResource

    def self.all
      fetch('entries')
    end

    # Fetches all entries. Supported options are:
    #  :people => ['ryan', 'frank']
    #  :projects => ['project1', 'project2']
    #  :tags => ['tag1', 'tag2']
    #  :from => '2011-01-01'
    #  :to => '2012-01-01'
    #  :billable => true/false
    def self.find(options = {})
      fetch('entries', build_search_options(options))
    end

    # Creates a new entry. Supported options are:
    #  :minutes => '4h'
    #  :user => 'user@example.com'
    #  :project_id => 3221
    #  :description => 'new task'
    #  :date => '2011-08-01'
    # NOTE: only minutes and user are required
    def self.create(options = {})
      raise ArgumentError, ':user missing' unless options.has_key?(:user)
      raise ArgumentError, ':minutes missing' unless options.has_key?(:minutes)
      post('entries', :entry => options)
    end

    def self.build_search_options(options = {})
      options.each_with_object({}) do |(key, value), result|
        case value
        when Array then result["search[#{key}]"] = value.join(',')
        else result["search[#{key}]"] = value.to_s
        end
      end
    end

    def initialize(delegate)
      super(delegate)
    end
  end
end