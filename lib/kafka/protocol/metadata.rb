require 'kafka/protocol/api'

module Kafka

  module Protocol

    class Metadata_v5

      API_KEY = 3
      API_VERSION = 0
      ALL_TOPICS = -1
      NO_TOPICS = nil

      def request(**message)
        Struct.new(:topic, :allow_auto_topic_creation, pack: "A*C", keyword_init: true).new(@message)
      end

      def response(message)

      end
        Brokers = Struct.new(:node_id, :host, :port, :rack)
        Partitions = Struct.new(:error_code, :partition, :leader, :replicas, :isr, :offline_replicas)
        Topics = Struct.new(:error_code, :topic, :is_internal, :partitions).new(nil, nil, nil, Partitions)
        Struct.new(:throttle_time_ms, :brokers, :cluster_id, :controller_id, :topics).new(nil, Brokers.new, nil, nil, Topics.new)
      end


    end

    class Metadata

      def initialize(api_key, api_version)
        @schema = Object.const_get("Metadata_v" + api_version)

      end

      def generator(api_key, api_version)
        case api_version
        when 5
          Struct.new(:message) do
            def topics
              message[:topics]
            end
            def allow_auto_topic_creation
            def request(message)
              Struct.new(:topics, :allow_auto_topic_creation, :pack = "A*C", keyword_init: true).new(**message)
            end
            def all_topics
              -1
            end
            def no_topics
              nil
            end
          end
          {
              request: Struct.new(:message, :pack = "A*") do
                def topics
                  message[:topics]
                end
              end,
              response: Struct.new(:message, :)
              all_topics: -1
          }

        when 1, 2, 3
          {
              request: Struct.new(:topics, :pack = "A*"),
              all_topics: -1,
              no_topics: nil
          }
        when 4, 5
          {
              request: Struct.new(:topics, :allow_auto_topic_creation, :pack = "A*C"),
              all_topics: -1,
              notopics: nil
          }
        end
      end

      def self.request(**options)
        api_options = {
            api_key: 3,
            api_version: 5
        }.strictly_update!(options)
        metadata_options = {
            topics: nil,
            allow_auto_topic_creation: nil
        }.strictly_update!(options)

      end

    end

  end

end