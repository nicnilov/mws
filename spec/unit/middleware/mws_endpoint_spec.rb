require 'spec_helper'

describe Mws::Middleware::MwsEndpoint do
  describe '.call' do
    subject { lambda { middleware.call(nil) } }

    context 'when the instance url is not set' do
      before do
        allow(client).to receive_message_chain(:connection, :url_prefix).and_return(URI.parse('http:/'))
      end

      it { should raise_error Mws::ConfigurationError }
    end

    context 'when the instance url is set' do
      before do
        allow(client).to receive_message_chain(:connection, :url_prefix).and_return(URI.parse('http://foobar.com/'))
        expect(app).to receive(:call).once
      end

      it { should_not raise_error }
    end
  end
end
