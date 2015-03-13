module MiddlewareExampleGroup
  def self.included(base)
    base.class_eval do
      let(:app)            { double('@app', :call => nil)            }
      let(:env)            { { :request_headers => {}, :response_headers => {} } }
      let(:retries)        { 3 }
      let(:options)        { { } }
      let(:client)         { double(Mws::Client) }
      subject(:middleware) { described_class.new app, client, options }
    end
  end

  RSpec.configure do |config|
    config.include self, :file_path => %r{spec/unit/middleware}
  end
end

