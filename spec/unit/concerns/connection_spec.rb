require 'spec_helper'

describe Mws::Concerns::Connection do
  describe '.middleware' do
    subject       { client.middleware }
    let(:builder) { double('Faraday::Builder') }

    before do
      expect(client).to receive_message_chain(:connection, :builder).and_return(builder)
    end

    it { should eq builder }
  end

  describe '#adapter' do
    before do
      expect(client).to receive(:options).and_return({:adapter => :typhoeus})
    end

    its(:adapter) { should eq(:typhoeus) }
  end
end
