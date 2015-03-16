module Mws

  # Middleware which asserts that the mws endpoint is always set
  class Middleware::MwsEndpoint < Mws::Middleware

    def call(env)
      # If the connection url_prefix isn't set, we cannot proceed
      raise Mws::ConfigurationError, 'MWS endpoint not set' unless url_prefix_set?
      @app.call(env)
    end

    def url_prefix_set?
      !!(connection.url_prefix && connection.url_prefix.host)
    end
  end
end
