require 'spec_helper'

describe Mws::Middleware::RaiseError do
  let(:body)       { {'ErrorResponse'=>{'Error'=>{'Code'=>'INVALID_FIELD','Message'=>'error_message'}}} }
  let(:env)        { { :status => status, :body => body } }
  let(:middleware) { described_class.new app }

  describe '.on_complete' do
    subject { lambda { middleware.on_complete(env) } }

    context 'when the status code is 404' do
      let(:status) { 404 }
      it { should raise_error Faraday::Error::ResourceNotFound, 'INVALID_FIELD: error_message' }
    end

    context 'when the status code is 400' do
      let(:status) { 400 }
      it { should raise_error Faraday::Error::ClientError, 'INVALID_FIELD: error_message' }
    end

    context 'when the status code is 401' do
      let(:status) { 401 }
      it { should raise_error Mws::AuthorizationError, 'INVALID_FIELD: error_message' }
    end

    context 'when the status code is 413' do
      let(:status) { 413 }
      let(:body) { '' } # Zero length response
      it { should raise_error Faraday::Error::ClientError, 'HTTP 413 - Request Entity Too Large' }
    end
  end
end
