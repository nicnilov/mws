module Mws

  class Middleware::Signature < Faraday::Middleware

    def call(env)
      @app.call(env)
    end
  end
end
