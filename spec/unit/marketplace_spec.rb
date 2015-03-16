require 'spec_helper'

describe Mws::Marketplace do

  describe '#mws_endpoint_url' do

    context 'with valid param' do
      it 'should return endpoint url' do
        expect(Mws::Marketplace.mws_endpoint_url('ATVPDKIKX0DER')).to eq('https://mws.amazonservices.com')
      end
    end

    context 'with invalid param' do
      it 'should throw error' do
        expect { 
          Mws::Marketplace.mws_endpoint_url(nil)
        }.to raise_error Mws::InvalidMarketplaceIdError
      end
    end
  end

end
