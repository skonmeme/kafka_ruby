module Kafka

  class Error < StandardError

    def initialize(data)
      STDERR.puts data
    end

  end

  class NoBroker < Error
  end

  class WrongURI < Error

    def initialize(data)
      @uri = data
      super
    end

  end

end