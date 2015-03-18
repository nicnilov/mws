module Mws
  class Middleware::RaiseError < Faraday::Response::Middleware
    def on_complete(env)
      @env = env
      case env[:status]
      when 404
        raise Faraday::Error::ResourceNotFound, message
      when 401
        raise Mws::AuthorizationError, message
      when 413
        raise Faraday::Error::ClientError.new('HTTP 413 - Request Entity Too Large', env[:response])
      when 503
        # Pass through if RequestThrottled
        unless body['ErrorResponse']['Error']['Code'] == 'RequestThrottled'
          raise Faraday::Error::ClientError.new(message, env[:response])
        end
      when 400...600
        raise Faraday::Error::ClientError.new(message, env[:response])
      end
    end

    def message
      "#{body['ErrorResponse']['Error']['Code']}: #{body['ErrorResponse']['Error']['Message']}"
    end

    def body
      @env[:body]
    end
  end
end
