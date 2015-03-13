require 'logger'

module Mws
  # Shamelessly pulled from https://github.com/ejholmes/restforce/blob/master/lib/restforce/config.rb
  class << self
    attr_writer :log

    # Returns the current Configuration
    #
    # Example
    #
    #    Mws.configuration.seller_id = "seller_id"
    #    Mws.configuration.marketplace_id = "marketplace_id"
    def configuration
      @configuration ||= Configuration.new
    end

    # Yields the Configuration
    #
    # Example
    #
    #    Mws.configure do |config|
    #      config.seller_id = "seller_id"
    #      config.marketplace_id = "marketplace_id"
    #    end
    def configure
      yield configuration
    end

    def log?
      @log ||= false
    end

    def log(message)
      return unless Mws.log?
      Mws.configuration.logger.send :debug, message
    end
  end

  class Configuration
    class Option
      attr_reader :configuration, :name, :options

      def self.define(*args)
        new(*args).define
      end

      def initialize(configuration, name, options = {})
        @configuration, @name, @options = configuration, name, options
        @default = options.fetch(:default, nil)
      end

      def define
        write_attribute
        define_method if default_provided?
        self
      end

    private
      attr_reader :default
      alias_method :default_provided?, :default

      def write_attribute
        configuration.send :attr_accessor, name
      end

      def define_method
        our_default = default
        our_name    = name
        configuration.send :define_method, our_name do
          instance_variable_get(:"@#{our_name}") ||
            instance_variable_set(:"@#{our_name}", our_default.respond_to?(:call) ? our_default.call : our_default)
        end
      end
    end

    class << self
      attr_accessor :options

      def option(*args)
        option = Option.define(self, *args)
        (self.options ||= []) << option.name
      end
    end

    # Seller account id on Amazon MWS.
    option :seller_id, :default => lambda { ENV['AMWS_SELLER_ID'] }

    # Marketplace id on Amazon MWS.
    option :marketplace_id, :default => lambda { ENV['AMWS_MARKETPLACE_ID'] }

    # Access key to incude with requests.
    option :aws_access_key, :default => lambda { ENV['AMWS_ACCESS_KEY'] }

    # Client secret to sign requests with.
    option :aws_access_secret, :default => lambda { ENV['AMWS_ACCESS_SECRET'] }

    # The number of times reauthentication should be tried before failing.
    option :authentication_retries, :default => 3

    # Faraday request read/open timeout.
    option :timeout

    # TODO: Not sure this will be needed in the end
    option :instance_url

    # Faraday adapter to use. Defaults to Faraday.default_adapter.
    option :adapter, :default => lambda { Faraday.default_adapter }

    option :proxy_uri, :default => lambda { ENV['PROXY_URI'] }

    # A Proc that is called with the response body after a successful authentication.
    option :authentication_callback

    def logger
      @logger ||= ::Logger.new STDOUT
    end

    def options
      self.class.options
    end
  end
end
