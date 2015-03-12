module Mws
  module Concerns
    module Base

      attr_reader :options

      # Public: Creates a new client instance
      #
      # opts - A hash of options to be passed in (default: {}).
      #        :seller_id              - Amazon MWS seller id as shown when registering
      #        :marketplace_id         - Amazon MWS marketplace id
      #        :aws_access_key         - Amazon AWS API key
      #        :aws_access_secret      - Amazon AWS API secret key
      #
      #        :authentication_retries - The number of times that client
      #                                  should attempt to reauthenticate
      #                                  before raising an exception (default: 3).
      #        :timeout                - Faraday connection request read/open timeout. (default: nil).
      #
      #        :proxy_uri              - Proxy URI: 'http://proxy.example.com:port' or 'http://user@pass:proxy.example.com:port'
      #
      #        :authentication_callback
      #                                - A Proc that is called with the response body after a successful authentication.
      def initialize(opts = {})
        raise ArgumentError 'Please specify hash of opts' unless opts.is_a?(Hash)
        @options = Hash[Mws.configuration.options.map { |option| [option, Mws.configuration.send(option)] }]
        @options.merge(opts)
        yield builder if block_given?
      end

#      def instance_url
#        TODO: infer from marketplace id
#      end

      def inspect
        "#<#{self.class} @options=#{@options.inspect}>"
      end
    end
  end
end
