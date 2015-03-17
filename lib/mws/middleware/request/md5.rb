module Mws

  class Middleware::Md5 < Faraday::Middleware

    def call(env)
      env[:request_headers]['Content-MD5'] = md5(env[:body])
      @app.call(env)
    end

    def md5(string)
      Base64.encode64(OpenSSL::Digest::MD5.digest(string)).strip
    end
  end
end
