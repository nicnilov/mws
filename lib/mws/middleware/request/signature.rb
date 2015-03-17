module Mws

  class Middleware::Signature < Faraday::Middleware

    def call(env)
      env[:request_headers]['User-Agent'] = user_agent
      @app.call(env)
    end
  end
end
