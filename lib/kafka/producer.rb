require 'kafka/cluster'

module Kafka

  class Producer

    ACKS = [:all, -1, 0, 1]
    COMPRESSION_TYPE = { none: 'none', gzip: 'gzip', snappy: 'snappy', lz4: 'lz4' }

    def initialize(**options)
      producer_options = {
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

      producer_options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      @brokers = Cluster.new(**options)

    end

    def send(message:, topic:)

    end

  end

end