require 'spec_helper'

describe Mws::Marketplace do
  let(:dummy_class) { 
    Class.new do 
      include Mws::Marketplace
    end
  }
  subject { dummy_class.new }

  describe '.mws_endpoint_url' do
    context 'with valid param' do
      it 'should return endpoint url' do
        expect(subject.mws_endpoint_url('ATVPDKIKX0DER')).to eq('https://mws.amazonservices.com')
      end
    end

    context 'with invalid param' do
      it 'should throw error' do
        expect { 
          subject.mws_endpoint_url(nil)
        }.to raise_error Mws::InvalidMarketplaceIdError
      end
    end
  end

  describe '.mws_endpoint_encoding' do
    context 'by default' do
      it 'should return ISO-8859-1' do
        expect(subject.mws_endpoint_encoding('ATVPDKIKX0DER')).to eq('ISO-8859-1')
      end
    end

    context 'for japanese endpoint' do
      it 'should return Shift_JIS' do
        expect(subject.mws_endpoint_encoding('A1VC38T7YXB528')).to eq('Shift_JIS')
      end
    end

    context 'for chinese endpoint' do
      it 'should return UTF-16' do
        expect(subject.mws_endpoint_encoding('AAHKV2X7AFYLW')).to eq('UTF-16')
      end
    end

    context 'with invalid param' do
      it 'should throw error' do
        expect { 
          subject.mws_endpoint_encoding(nil)
        }.to raise_error Mws::InvalidMarketplaceIdError
      end
    end
  end
end
