
module Kafka

  class Consumer

    def initialize(**options)
      @connection_options = {

      }.strictly_update!(options)
      @consumer_options = {

      }.strictly_update!(options)

    end

  end

end