module Kafka

  class Error < StandardError

    def initialize(data = nil)
      super
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

  class MissingRequiredArugment < Error

    def initialize(data)
      @argument = data
      super(data)
    end

  end

end