require 'builder'

module Mws
  module Concerns
    module Envelope

      def envelope
        xml = Builder::XmlMarkup.new
        xml.instruct!(:xml, :version=>"1.0", :encoding=>"#{mws_endpoint_encoding(options[:mws_endpoint])}")
        xml.AmazonEnvelope('xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                           'xsi:noNamespaceSchemaLocation' => 'amzn-envelope.xsd') do |xml|
          xml.Header do |xml|
            xml.DocumentVersion('1.01')
            xml.MerchantIdentifier(options[:seller_id])
          end

          yield xml
        end
        xml
      end
    end
  end
end
