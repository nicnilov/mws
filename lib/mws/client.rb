module Mws
  class Client
    include Mws::Concerns::Base
    include Mws::Concerns::Connection
    include Mws::Concerns::Feeds
  end
end
