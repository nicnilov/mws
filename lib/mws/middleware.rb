module Mws
  # Todo: Due to autoloading stuff convenience method should be placed to a separate
  # base class
  class Middleware < Faraday::Middleware
    autoload :MwsEndpoint,    'mws/middleware/request/mws_endpoint'
    autoload :UserAgent,      'mws/middleware/request/user_agent'
    autoload :XmlRequest,     'mws/middleware/request/xml'
    autoload :RaiseError,     'mws/middleware/response/raise_error'
    # autoload :Mashify,        'mws/middleware/response/mashify'
    autoload :Logger,         'mws/middleware/logger'

    Faraday::Request.register_middleware(:mws_endpoint => lambda { Mws::Middleware::MwsEndpoint },
                                         :user_agent => lambda { Mws::Middleware::UserAgent })

    Faraday::Response.register_middleware(:raise_error => lambda { Mws::Middleware::RaiseError })

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
