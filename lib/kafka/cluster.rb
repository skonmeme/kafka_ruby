require 'uri'
require 'kafka/broker'

module Kafka

  class Cluster

    DEFAULT_PORT = "9092"
    SECURITY_PROTOCOL = { PLAINTEXT: 'plaintext', SSL: 'ssl', plaintext: 'plaintext', ssl: 'ssl' }
    SSL_PROTOCOLS = { TLS_1_2: 'TLSv1.2', TLS_1_1: 'TLSv1.1', TLS_1: 'TLSv1' }

    def initialize(**options)
      connection_options = {
          bootstrap_servers: nil,
          client_id: 'kafka_ruby',
          ssl_key_password: nil,
          ssl_keystore_location: nil,
          ssl_keystore_password: nil,
          ssl_truststore_location: nil,
          ssl_truststore_password: nil,
          sasl_jaas_config: nil,
          sasl_kerberos_service_name: nil,
          sasl__mechanism: :GSSAPI,
          security_protocol: :PLAINTEXT,
          ssl_enabled_protocols: [:TLS_1_2, :TLS_1_1, :TLS_1],
          ssl_keystore_type: :JKS,
          ssl_protocol: :TLS,
          ssl_provider: nil,
          ssl_truststore_type: :JKS,
          sasl_kerberos_kinit_cmd: '/usr/bin/kinit',
          sasl_kerberos_min_time_before_relogin: 60 * 1000,
          sasl_kerberos_ticket_renew_jitter: 0.05,
          sasl_kerberos_ticket_renew_window_factor: 0.8,
          ssl_cipher_suites: [],
          ssl_endpoint_identification_algorithm: nil,
          ssl_keymanager_algorithm: :X509,
          ssl_secure_random_implementation: nil,
          ssl_trustmanager_algorithm: :PKIX
      }.strictly_update!(options)

      # set options
      raise Kafka::NoBroker unless connection_options[:bootstrap_servers]
      connection_options[:bootstrap_servers] = parse_servers(connection_options[:bootstrap_servers])
      connection_options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      # fetch broker information
      @brokers = @bootstrap_servers.shuffle.map do |server|
        metadata = Protocol::Metadata.request
      end

    end

    def parse_servers(servers)
      servers = servers.split(",") if servers.is_a?(String)
      servers.map do |server|
        server = "kafka://" + server unless server.include?("://")
        uri = URI.parse(server)
        uri.port ||= DEFAULT_PORT
        uri.scheme = case uri.scheme
                     when "plaintext"
                       "kafka"
                     when "ssl"
                       "kafka+ssl"
                     else
                       "kafka"
                     end
        raise Kafka::WrongURI.new(uri) unless SECURITY_PROTOCOL[uri.scheme.to_sym] if uri.scheme
      end
    end

  end

end