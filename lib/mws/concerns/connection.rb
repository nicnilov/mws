module Mws
  module Concerns
    module Connection

      attr_accessor :throttling_status

      # Public: The Faraday::Builder instance used for the middleware stack. This
      # can be used to insert a custom middleware.
      #
      # Examples
      #
      #   # Add the instrumentation middleware for Rails.
      #   client.middleware.use FaradayMiddleware::Instrumentation
      #
      # Returns the Faraday::Builder for the Faraday connection.
      def middleware
        connection.builder
      end
      alias_method :builder, :middleware

    private

      # Internal: Internal faraday connection where all requests go through
      def connection
        @connection ||= Faraday.new(mws_endpoint, connection_options) do |conn|
          conn.request  :multipart
          conn.request  :url_encoded

          # Ensures the mws endpoint url is set.
          conn.request  :mws_endpoint, self, options

          # Inserts user agent header as requested in Amazon MWS docs
          conn.request  :user_agent

          # Inserts request signature
          conn.request  :signature, self, options

          # Adds header with md5 calculated on body
          conn.request  :md5

          # Handles throttling events
          conn.response :throttle, self, options

          # Raises errors for 40x responses.
          conn.response :raise_error

          # Follows 34x redirects.
          conn.response :follow_redirects

          conn.response :xml

          # Log request/responses
          conn.use      Mws::Middleware::Logger, Mws.configuration.logger, options if Mws.log?

          conn.adapter  adapter
        end
      end

      def adapter
        options[:adapter]
      end

      # Internal: Faraday Connection options
      def connection_options
        { :request => {
            :timeout => options[:timeout],
            :open_timeout => options[:timeout] },
          :proxy => options[:proxy_uri]
        }
      end

    end
  end
end
