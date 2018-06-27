
module Kafka

  KAFKA_PORT_DEFAULT = '9092'

  class Broker

    IDLE_TIMEOUT = 60 * 5

    def initialize(host, port, **options)
      connection_options = {
          host: nil,
          port: nil,
          socket: nil,
          connect_timeout: 10,
          socket_timeout: 10,
          ssl_context: nil
      }.strictly_update!(options).each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def connected?
      !@socket.nil? && @socket
    end

    def close
      Kafka.logger.debug("Closing socket to #{@host}:#{@port}")
      @socket.close if @socket
    end

  end

  class BrokerBuilder


    def initialize(**options)

    end

  end


end