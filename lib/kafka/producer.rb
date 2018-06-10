
module Kafka

  class Producer

    ACKS = [:all, -1, 0, 1]
    COMPRESSION_TYPE = { none: 'none', lz4: 'lz4' }
    SECURITY_PROTOCOL = { PLAINTEXT: 'PLAINTEXT' }
    SSL_PROTOCOLS = { TLS_1_2: 'TLSv1.2', TLS_1_1: 'TLSv1.1', TLS_1: 'TLSv1' }

    def initialize(**options)
      @connection_optins = {
          bootstrap_servers: [],
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
      @producer_options = {
          key_serializer: :default,
          value_serializer: :default,
          acks: 1,
          buffer_memory: 32 * 1024 * 1024,
          compression_type: :NONE,
          retries: 0,
          batch_size: 16 * 1024,
          client_id: '',
          connections_max_idle_ms: 540 * 1000,
          linger_ms: 0,
          max_block_ms: 60 * 1000,
          max_request_size: 1024 * 1024,
          partitioner_class: :default,
          receive_buffer_bytes: 32 * 1024,
          request_timeout_ms: 30 * 1000,
          send_buffer_bytes: 128 * 1024,
          enable_idempotence: true,
          interceptor_classes: :default,
          max_in_flight_requests_per_connection: 5,
          metadata_max_age_ms: 300 * 1000,
          metric_reporters: nil,
          metrics_num_samples: 2,
          metrics_recording_level: :INFO,
          metrics_sample_window_ms: 30 * 1000,
          reconnect_backoff_max_ms: 1 * 1000,
          reconnect_backoff_ms: 50,
          retry_backoff_ms: 100,
          transaction_timeout_ms: 60 * 1000,
          transactional_id: nil
      }.strictly_update!(options)
    end

    @brokers = BrokerBuilder.new(@connection_optins)

  end

end