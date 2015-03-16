module Mws
  class Middleware::XmlRequest < Faraday::Middleware

    def call(env)
      if env[:method] == :post && Hash === env[:body]
        env[:body] = to_xml(env[:body])
      end
      @app.call(env)
    end

    def to_xml(hash)
      hash.map do |k, v|
        text = Hash === v ? to_xml(v) : v
        "<%s>%s</%s>" % [k, text, k]
      end.join
    end

  end
end
