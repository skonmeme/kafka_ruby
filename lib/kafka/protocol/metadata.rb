require 'kafka/protocol/api'

module Kafka

  module Protocol

    class Metadata_v0

      API_KEY = 3
      API_VERSION = 0

      def initialize

      end

    end

    class MetadataRequest_v0

      API_KEY = 32
      API_VERSION = 0

    end

    class Metadata

      def initialize(api_key, api_version)
        @schema = Object.const_get("Metadata_v" + api_version)

      end

      def schema(api_key, api_version)
        case api_version
        when 0
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