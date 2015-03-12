require 'faraday'
require 'faraday_middleware'

require 'mws/config'

module Mws
  autoload :Client, 'mws/client'

  module Concerns
    autoload :Connection, 'mws/concerns/connection'
    autoload :Base, 'mws/concerns/base'
  end

  class << self
    def new(*args)
      Mws::Client.new(*args)
    end
  end
end