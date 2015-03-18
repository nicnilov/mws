module Mws
  # Todo: Due to autoloading stuff convenience methods should be placed to a separate
  # base class
  class Middleware < Faraday::Middleware
    autoload :MwsEndpoint,    'mws/middleware/request/mws_endpoint'
    autoload :UserAgent,      'mws/middleware/request/user_agent'
    autoload :Signature,      'mws/middleware/request/signature'
    autoload :XmlRequest,     'mws/middleware/request/xml_request'
    autoload :Md5,            'mws/middleware/request/md5'
    autoload :RaiseError,     'mws/middleware/response/raise_error'
    autoload :Throttle,       'mws/middleware/response/throttle'
    autoload :Logger,         'mws/middleware/logger'

    Faraday::Request.register_middleware(:mws_endpoint => lambda { Mws::Middleware::MwsEndpoint },
                                         :user_agent => lambda { Mws::Middleware::UserAgent },
                                         :xml => lambda { Mws::Middleware::XmlRequest },
                                         :md5 => lambda { Mws::Middleware::Md5 },
                                         :signature => lambda { Mws::Middleware::Signature })

    Faraday::Response.register_middleware(:raise_error => lambda { Mws::Middleware::RaiseError },
                                          :throttle => lambda { Mws::Middleware::Throttle })

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
