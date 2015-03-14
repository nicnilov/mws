require 'mws/concerns/verbs'

module Mws
  module Concerns
    module Feeds
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

      def submit_feed(content, type)
      end

    end
  end
end
