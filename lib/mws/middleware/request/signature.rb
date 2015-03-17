module Mws

  class Middleware::Signature < Mws::Middleware

    def call(env)
      sign(env)
      @app.call(env)
    end

    def sign(env)
      method = env[:method].to_s.upcase
      host = env[:url].host
      path = env[:url].path
      params = Faraday::Utils.parse_query(env[:url].query).delete_if { |k, v| v.to_s == '' }.merge({
        'SignatureVersion' => '2',
        'SignatureMethod'  => 'HmacSHA256',
        'Timestamp'        => Time.now.utc.iso8601
      })
      query_string = canonicalized_query_string(params)
      signature = calculate_signature_for([method, host, path, query_string].join("\n"))
      env[:url].query = Faraday::Utils.build_query(params.merge('Signature' => signature))
    end

    def calculate_signature_for(string)
      Base64.encode64(
        OpenSSL::HMAC.digest( OpenSSL::Digest::SHA256.new, @options[:aws_access_secret], string)
      ).strip
    end

    def canonicalized_query_string(params)
      params.sort.map { |k, v| "#{k}=#{ escape(v) }" }.join('&')
    end

    def escape(value)
      value.to_s.gsub(/([^\w.~-]+)/) { '%' + $1.unpack("H2" * $1.bytesize).join('%').upcase }
    end
  end
end
