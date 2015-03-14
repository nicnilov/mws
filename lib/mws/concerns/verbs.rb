module Mws
  module Concerns
    module Verbs

      # Internal: Define methods to handle a verb.
      #
      # verbs - A list of verbs to define methods for.
      #
      # Examples
      #
      #   define_verbs :get, :post
      #
      # Returns nil.
      def define_verbs(*verbs)
        verbs.each do |verb|
          define_verb(verb)
        end
      end

      # Internal: Defines a method to handle HTTP requests with the passed in
      # verb.
      #
      # verb - Symbol name of the verb (e.g. :get).
      #
      # Examples
      #
      #   define_verb :get
      #   # => get '/example/resource'
      #
      # Returns nil.
      def define_verb(verb)
        define_method verb do |*args, &block|
          connection.send(verb, *args, &block)
        end
      end
    end
  end
end
