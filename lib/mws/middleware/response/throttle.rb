module Mws
  class Middleware::Throttle < Mws::Middleware

    def call(env)
      @app.call(env).on_complete do |env|
        if env[:status] == 503 && env[:body]['ErrorResponse']['Error']['Code'] == 'RequestThrottled'
          raise RequestThrottledError, message
        else
          # Setting throttling status from last successful request
          if env[:response_headers]['x-mws-quota-max']
            client.throttling_status = {
              x_mws_quota_max: env[:response_headers]['x-mws-quota-max'].to_i,
              x_mws_quota_remaining: env[:response_headers]['x-mws-quota-remaining'].to_i,
              x_mws_quota_resetson: Time.parse(env[:response_headers]['x-mws-quota-resetson']) # UTC
            }
          end
        end
      end
    end

    def message
      if (client.throttling_status ||= {})[:x_mws_quota_resetson]
        "Throttling resets in #{client.throttling_status[:x_mws_quota_resetson] - Time.now.utc } seconds"
      else
        'Throttling status unavailable, please repeat the request later'
      end
    end

  end
end
