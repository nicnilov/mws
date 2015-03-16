module Mws

  # Middleware which inserts user agent header as requested by Amazon MWS docs
  class Middleware::UserAgent < Faraday::Middleware

    def call(env)
      user_agent = "Mws/#{Mws::VERSION} (Language=Ruby/#{RUBY_VERSION}; Platform=#{RUBY_PLATFORM})"
      env[:request_headers]['User-Agent'] = user_agent
      @app.call(env)
    end
  end
end
