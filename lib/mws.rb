require 'faraday'
require 'faraday_middleware'

require 'mws/config'

module Mws
  autoload :Client,     'mws/client'
  autoload :Middleware, 'mws/middleware'

  module Concerns
    autoload :Connection, 'mws/concerns/connection'
    autoload :Base,       'mws/concerns/base'
    autoload :Verbs,      'mws/concerns/verbs'
    autoload :Feeds,      'mws/concerns/feeds'
  end

  Error = Class.new(StandardError)
  ConfigurationError = Class.new(Error)
  AuthorizationError = Class.new(Error)

  class << self
    def new(*args)
      Mws::Client.new(*args)
    end
  end
end
