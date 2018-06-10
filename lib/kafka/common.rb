require 'kafka/producer'
require 'kafka/consumer'

class Hash

  def strictly_update!(hash)
    self.merge!(hash.dup.delete_if { |key| !self.has_key?(key) })
  end

end

module Kafka

end