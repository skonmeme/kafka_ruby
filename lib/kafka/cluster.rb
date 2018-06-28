require 'uri'
require 'kafka/broker'

module Kafka

  class Cluster

    DEFAULT_PORT = "9092"
    SECURITY_PROTOCOL = { plaintext: :PLAINTEXT, ssl: :SSL, sasl_plaintext: :SASL_PLAINTEXT, sasl_ssl: :SASL_SSL }
    SSL_PROTOCOLS = { TLS_1_2: 'TLSv1.2', TLS_1_1: 'TLSv1.1', TLS_1: 'TLSv1' }

    def initialize(**options)
      connection_options = {
          topic: nil,
          bootstrap_servers: nil,
          security_protocol: :PLAINTEXT
      }.strictly_update!(options).required.each { |key, value| instance_variable_set("@#{key}", value) }
      @sasl_authenticator = {
          sasl_kerberos_ticket_renew_window_factor: 0.8,
          sasl_jaas_config: nil,
          sasl_kerberos_service_name: nil,
          sasl_mechanism: :GSSAPI,
          sasl_kerberos_kinit_cmd: '/usr/bin/kinit',
          sasl_kerberos_min_time_before_relogin: 60 * 1000,
          sasl_kerberos_ticket_renew_jitter: 0.05
      }.strictly_update!(options)

      raise Kafka::NoBroker unless @bootstrap_servers

      # fetch broker information
      @brokers = bootstrap_servers.shuffle.map do |bootstrap_server|
        broker = Borker.new(options.merge({host: bootstrap_server.host, port: bootstrap_server.port}))
        metadata = Protocol::Metadata.request(@topic)
      end

    end

    def bootstrap_servers
      servers = servers.split(",") if @bootstrap_servers.is_a?(String)
      @bootstrap_servers = servers.map do |server|
        uri = URI.parse(server)
        uri.port ||= DEFAULT_PORT
        uri.scheme = case @security_protocol
                     when :SSL
                       "ssl"
                     when :SASL_PLAINTEXT
                       "sasl_plaintext"
                     when :SASL_SSL
                       "sasl_ssl"
                     else
                       "plaintext"
                     end
        raise Kafka::WrongURI.new(uri) if uri.scheme.nil? || SECURITY_PROTOCOL[uri.scheme.to_sym].nil?
      end
    end

  end

end