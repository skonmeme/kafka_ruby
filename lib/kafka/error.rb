module Kafka

  class Error < StandardError
  end

  class WrongURI < Error

    def initialize(uri)
      @uri = uri
    end

  end

end