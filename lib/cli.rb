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
      raise ArgumentError, 'Every parameter should have a value' if value.to_s == ''
    end

    @mws = Mws.new({
      seller_id: merchant_id,
      marketplace_id: marketplace_id,
      aws_access_key: aws_access_key,
      aws_access_secret: aws_access_secret
    })

    submission_id = submit_product_test

    say('Sleeping for 15 sec before requesting submission result...')

    sleep(15)

    say('Requesting submission result...')

    # Submission result will not likely be ready in 15 seconds
    begin
      response = @mws.get_feed_submission_result(submission_id)
      say("Submission result:\n" + response.body.to_s)
    rescue Faraday::Error::ResourceNotFound => error
      say(error.message)
    end
  end

  def self.submit_product_test
    say('Submitting product feed...')

    response = @mws.submit_feed('_POST_PRODUCT_DATA_') do |xml|
      build_example_product(xml)
    end

    say("Submitted successfully. Feed submission info:\n" + response.body.to_s)
    response.body['SubmitFeedResponse']['SubmitFeedResult']['FeedSubmissionInfo']['FeedSubmissionId']
  end

  def self.build_example_product(xml)
    # Building a product data payload manually. Knowledge of schema would
    # probably allow for an automated way.
    xml.MessageType('Product')
    xml.PurgeAndReplace(false)
    xml.Message do |xml|
      xml.MessageID(SecureRandom.random_number(1000000))
      xml.OperationType('Update')
      xml.Product do |xml|
        xml.SKU('56789')
        xml.StandardProductID do |xml|
          xml.Type('ASIN')
          xml.Value('B0EXAMPLEG')
        end
        xml.ProductTaxCode('A_GEN_NOTAX')
        xml.DescriptionData do |xml|
          xml.Title('Example Product Title')
          xml.Brand('Example Product Brand')
          xml.Description('This is an example product description.')
          xml.BulletPoint('Example Bullet Point 1')
          xml.BulletPoint('Example Bullet Point 2')
          xml.MSRP('25.19', 'currency' => 'USD')
          xml.Manufacturer('Example Product Manufacturer')
          xml.ItemType('example-item-type')
        end
        xml.ProductData do |xml|
          xml.Health do |xml|
            xml.ProductType do |xml|
              xml.HealthMisc do |xml|
                xml.Ingredients('Example Ingredients')
                xml.Directions('Example Directions')
              end
            end
          end
        end
      end
    end
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
  say("#{error.class}: #{error.message}\n\n#{error.backtrace}")
end
