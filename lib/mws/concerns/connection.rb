module Mws
  module Concerns
    module Connection

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
        @connection ||= Faraday.new(mws_endpoint, connection_options) do |builder|
          # Converts the request into json.
          # builder.request :json
          # Ensures the instance url is set.
          builder.use      Mws::Middleware::MwsEndpoint, self, options
          # Follows 34x redirects.
          builder.use      FaradayMiddleware::FollowRedirects
          # Raises errors for 40x responses.
          builder.use      Mws::Middleware::RaiseError
          builder.response :xml
          # Log request/responses
          builder.use      Mws::Middleware::Logger, Mws.configuration.logger, options if Mws.log?

          builder.adapter  adapter
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
