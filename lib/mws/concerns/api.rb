module Mws
  module Concerns
    module Api
      extend Mws::Concerns::Verbs

      # Public: Helper methods for performing arbitrary actions against the API using
      # various HTTP verbs.
      #
      # Examples
      #
      #   # Perform a get request
      #   client.get '/example/resource'
      #
      #   # Perform a post request
      #   client.post '/example/resource', { ... }
      #
      #   # Perform a put request
      #   client.put '/example/resource', { ... }
      #
      #   # Perform a delete request
      #   client.delete '/example/resource'
      #
      # Returns the Faraday::Response.
      define_verbs(:get, :post, :put, :delete, :patch, :head)

      def request(payload = nil, params = {}, &block)
        raise ArgumentError, 'Supply either payload or block' if block_given? && payload.to_s != ''
        body = block_given? ? (envelope &block) : payload

        post do |req|
          req.path = '/'
          req.params.merge!(params).merge!(default_params)
          req.headers['Content-Type'] = 'text/xml'
          req.body = body
        end
      end

      private

      def default_params
        {
          'AWSAccessKeyId' => options[:aws_access_key],
          'SellerId' => options[:seller_id],
          'MWSAuthToken' => options[:mws_auth_token]
        }
      end
    end
  end
end
