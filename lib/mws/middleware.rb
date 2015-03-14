module Mws
  # Base class that all middleware can extend. Provides some convenient helper
  # functions.
  class Middleware < Faraday::Middleware
    autoload :RaiseError,     'mws/middleware/raise_error'
    autoload :MwsEndpoint,    'mws/middleware/mws_endpoint'
    # autoload :Mashify,        'mws/middleware/mashify'
    autoload :Logger,         'mws/middleware/logger'

    def initialize(app, client, options)
      @app, @client, @options = app, client, options
    end

    # Internal: Proxy to the client.
    def client
      @client
    end

    # Internal: Proxy to the client's faraday connection.
    def connection
      client.send(:connection)
    end
  end
end
