module Mws
  module Marketplace
    MWS_ENDPOINTS = {
      A2EUQ1WTGCTBG2: 'https://mws.amazonservices.ca',
      ATVPDKIKX0DER: 'https://mws.amazonservices.com',
      A1PA6795UKMFR9: 'https://mws-eu.amazonservices.com',
      A1RKKUPIHCS9HS: 'https://mws-eu.amazonservices.com',
      A13V1IB3VIYZZH: 'https://mws-eu.amazonservices.com',
      A21TJRUUN4KGV: 'https://mws.amazonservices.in',
      APJ6JRA9NG5V4: 'https://mws-eu.amazonservices.com',
      A1F83G8C2ARO7P: 'https://mws-eu.amazonservices.com',
      A1VC38T7YXB528: 'https://mws.amazonservices.jp',
      AAHKV2X7AFYLW: 'https://mws.amazonservices.com.cn'
    }


    def mws_endpoint_encoding(id)
      endpoint_url = mws_endpoint_url(id)
      if endpoint_url.end_with?('jp')
        'Shift_JIS'
      elsif endpoint_url.end_with?('cn')
        'UTF-16'
      else
        'ISO-8859-1'
      end
    end

    def mws_endpoint_url(id)
      MWS_ENDPOINTS.fetch(id.to_s.to_sym) { raise Mws::InvalidMarketplaceIdError, "'#{id.to_s}'" }
    end
  end
end
