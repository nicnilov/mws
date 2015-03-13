require 'dotenv'
require 'highline/import'
require_relative 'mws'

module Cli
  def self.execute
    display_welcome
    merchant_id = ask('Seller ID: ') { |q| q.default = ENV['AMWS_SELLER_ID'] }
    marketplace_id = ask('Marketplace ID: ') { |q| q.default = ENV['AMWS_MARKETPLACE_ID'] }
    aws_access_key = ask('AWS Access Key ID: ') { |q| q.default = ENV['AMWS_ACCESS_KEY'] }
    aws_access_secret = ask('Secret Key: ') { |q| q.default = ENV['AMWS_ACCESS_SECRET'] }

    [merchant_id, marketplace_id, aws_access_key, aws_access_secret].each do |value|
      throw 'Every parameter should have a value' if value.to_s == ''
    end

    @mws = Mws.new
  end

  def self.display_welcome
    say("================================================================\n"\
        "                      Amazon MWS client                         \n"\
        "                                                                \n"\
        "              Please enter Amazon MWS credentials               \n"\
        '================================================================')
  end

end

begin
  Dotenv.load(File.expand_path('../../.env', __FILE__))
  Cli.execute
  say('Finished successfully')
rescue => error
  say("Exception: #{error.message}\n\n#{error.backtrace}")
end
