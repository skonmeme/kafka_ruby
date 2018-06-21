require 'hash'
require 'kafka/logger'
require 'kafka/version'

module Kafka

  @logger = Kafka::Logger.new(nil)

  def self.producer(**options)
    Producer.new(**options)
  end

  def self.consumer(**options)
    Consumer.new(**options)
  end

end

require 'kafka/common'