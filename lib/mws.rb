require 'faraday'
require 'faraday_middleware'

require 'mws/version'
require 'mws/config'
require 'mws/middleware'

module Mws
  autoload :Client,       'mws/client'
  autoload :Marketplace,  'mws/marketplace'
  # autoload :Middleware,  'mws/middleware'

  module Concerns
    autoload :Connection, 'mws/concerns/connection'
    autoload :Base,       'mws/concerns/base'
    autoload :Verbs,      'mws/concerns/verbs'
    autoload :Envelope,   'mws/concerns/envelope'
    autoload :Api,        'mws/concerns/api'
  end

  Error = Class.new(StandardError)
  ConfigurationError = Class.new(Error)
  AuthorizationError = Class.new(Error)
  InvalidMarketplaceIdError = Class.new(Error)

  class << self
    def new(*args)
      Mws::Client.new(*args)
    end
  end
end
