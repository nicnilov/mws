require 'spec_helper'

describe Mws do
  before do
    ENV['AMWS_SELLER_ID']      = nil
    ENV['AMWS_MARKETPLACE_ID'] = nil
    ENV['AMWS_AUTH_TOKEN']     = nil
    ENV['AMWS_ACCESS_KEY']     = nil
    ENV['AMWS_ACCESS_SECRET']  = nil
    ENV['PROXY']               = nil
  end

  after do
    Mws.instance_variable_set :@configuration, nil
  end

  describe '#configuration' do
    subject { Mws.configuration }

    it { should be_a Mws::Configuration }

    context 'by default' do
      its(:adapter)                { should eq Faraday.default_adapter }
      [:seller_id, :marketplace_id, :aws_access_key, :aws_access_secret,
       :mws_auth_token, :mws_endpoint, :timeout, :proxy_uri].each do |attr|
        its(attr) { should be_nil }
      end
    end

    context 'when environment variables are defined' do
      before do
        { 'AMWS_SELLER_ID'       => 'foo',
          'AMWS_MARKETPLACE_ID'  => 'bar',
          'AMWS_AUTH_TOKEN'      => 'hey',
          'AMWS_ACCESS_KEY'      => 'foobar',
          'AMWS_ACCESS_SECRET'   => 'baz',
          'PROXY_URI'            => 'proxy',
        }.each { |var, value| allow(ENV).to receive(:[]).with(var).and_return(value) }
      end

      its(:seller_id)         { should eq 'foo' }
      its(:marketplace_id)    { should eq 'bar'}
      its(:mws_auth_token)    { should eq 'hey'}
      its(:aws_access_key)    { should eq 'foobar' }
      its(:aws_access_secret) { should eq 'baz' }
      its(:proxy_uri)         { should eq 'proxy' }
    end
  end

  describe '#configure' do
    [:seller_id, :marketplace_id, :aws_access_key, :aws_access_secret, :timeout,
     :mws_auth_token, :mws_endpoint, :proxy_uri].each do |attr|
      it "allows #{attr} to be set" do
        Mws.configure do |config|
          config.send("#{attr}=", 'foobar')
        end
        expect(Mws.configuration.send(attr)).to eq 'foobar'
      end
    end
  end

  describe '#log?' do
    subject { Mws.log? }

    context 'by default' do
      it { should be false }
    end
  end

  describe '#log' do
    context 'with logging disabled' do
      before do
        expect(Mws).to receive(:log?).and_return(false)
      end

      it 'doesnt log anytning' do
        expect(Mws.configuration.logger).not_to receive(:debug)
        Mws.log 'foobar'
      end
    end

    context 'with logging enabled' do
      before do
        expect(Mws).to receive(:log?).and_return(true)
        expect(Mws.configuration.logger).to receive(:debug).with('foobar')
      end

      it 'logs something' do
        Mws.log 'foobar'
      end
    end
  end
end
