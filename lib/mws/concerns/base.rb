module Mws
  module Concerns
    module Base

      attr_reader :options

      # Public: Creates a new client instance
      #
      # opts - A hash of options to be passed in (default: {}).
      #        :seller_id              - Amazon MWS seller id as shown when registering
      #        :marketplace_id         - Amazon MWS marketplace id
      #        :mws_auth_token         - Amazon MWS token for accessing third-party accounts
      #        :aws_access_key         - Amazon AWS API key
      #        :aws_access_secret      - Amazon AWS API secret key
      #
      #        :timeout                - Faraday connection request read/open timeout. (default: nil).
      #
      #        :proxy_uri              - Proxy URI: 'http://proxy.example.com:port' or 'http://user@pass:proxy.example.com:port'
      #
      def initialize(opts = {})
        raise ArgumentError, 'Please specify a hash of options' unless opts.is_a?(Hash)
        @options = Hash[Mws.configuration.options.map { |option| [option, Mws.configuration.send(option)] }]
        @options.merge(opts)
        yield builder if block_given?
      end

      def mws_endpoint
        options[:mws_endpoint] = mws_endpoint_url(options[:marketplace_id]) unless options[:mws_endpoint]
        options[:mws_endpoint]
      end

      def inspect
        "#<#{self.class} @options=#{@options.inspect}>"
      end
    end
  end
end
