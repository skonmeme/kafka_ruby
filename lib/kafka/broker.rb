
module Kafka

  KAFKA_PORT_DEFAULT = '9092'

  class Broker

    IDLE_TIMEOUT = 60 * 5

    def initialize(**options)
      connection_options = {
          host: nil,
          port: nil,
          client_id: 'kafka_ruby',
          socket: nil,
          connect_timeout: 10,
          socket_timeout: 10,
          ssl_context: nil
      }.strictly_update!(options).required.each { |key, value| instance_variable_set("@#{key}", value) }
      @ssl_context = {
          ssl_key_password: nil,
          ssl_keystore_location: nil,
          ssl_keystore_password: nil,
          ssl_truststore_location: nil,
          ssl_truststore_password: nil,
          ssl_enabled_protocols: [:TLS_1_2, :TLS_1_1, :TLS_1],
          ssl_keystore_type: :JKS,
          ssl_protocol: :TLS,
          ssl_provider: nil,
          ssl_truststore_type: :JKS,
          ssl_cipher_suites: [],
          ssl_endpoint_identification_algorithm: nil,
          ssl_keymanager_algorithm: :X509,
          ssl_secure_random_implementation: nil,
          ssl_trustmanager_algorithm: :PKIX
      }.strictly_update!(options)
    end

    def connected?
      !@socket.nil? && @socket
    end

    def connect
    end

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