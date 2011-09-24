module LetsFreckle
  class Error < StandardError
  end

  class FetchError < Error
    def initialize(status)
      super("Fetch failed, HTTP error: #{status}")
    end
  end

  class CreateError < Error
    def initialize(status)
      super("Create failed, HTTP error: #{status}")
    end
  end
end
