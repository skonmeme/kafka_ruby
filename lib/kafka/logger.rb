require 'logger'

module Kafka

  class << self
    attr_accessor :logger

    def logger
      @logger ||= Logger.new(nil)
    end

  end

end