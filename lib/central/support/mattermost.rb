require "net/http"
require "uri"

module Central
  module Support
    module MattermostHelper
      def send_mattermost(integration, message)
        Central::Support::Mattermost.send(real_private_uri(integration.data['private_uri'] ),
                        integration.data['channel'],
                        integration.data['bot_username'],
                        message)
      end

      private def real_private_uri(private_uri)
        if private_uri.starts_with? "INTEGRATION_URI"
          ENV[private_uri]
        else
          private_uri
        end
      end
    end

    class Mattermost
      def self.send(private_uri, project_channel, bot_username, message)
        Mattermost.new(private_uri, project_channel, bot_username).send(message)
      end

      def initialize(private_uri, project_channel = "off-topic", bot_username = "marvin")
        @private_uri = URI.parse(private_uri)
        @project_channel = project_channel
        @bot_username = bot_username
      end

      def send(text)
        if Rails.env.development?
          Rails.logger.debug("NOT SENDING TO OUTSIDE INTEGRATION!")
          Rails.logger.debug("URL: #{@private_uri}")
          Rails.logger.debug("Payload: #{payload(text)}")
        else
          Net::HTTP.post_form(@private_uri, {"payload" => payload(text)})
        end
      end

      def payload(text)
        {
          username: @bot_username,
          channel: @project_channel,
          attachments: text
        }.to_json
      end
    end
  end
end
