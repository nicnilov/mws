# MWS

[![travis-ci](https://travis-ci.org/nicnilov/mws.png?branch=master)](https://travis-ci.org/nicnilov/mws) [![Code Climate](https://codeclimate.com/repos/55047d886956806dde003e4d/badges/eb187fcc36fcc0c8d786/gpa.svg)](https://codeclimate.com/repos/55047d886956806dde003e4d/feed) [![Dependencies Status](https://gemnasium.com/nicnilov/mws.svg)](https://gemnasium.com/nicnilov/mws)

Amazon MWS API client

## Requirements
1. Have Amazon MWS credentials ready ([Read how to get these](http://docs.developer.amazonservices.com/en_US/dev_guide/DG_Registering.html)):
  * Amazon MWS Seller Id (or place into `AMWS_SELLER_ID` environment variable)
  * Amazon MWS Marketplace Id (or place into `AMWS_MARKETPLACE_ID` environment variable)
  * Amazon AWS Access Key (or place into `AMWS_ACCESS_KEY` environment variable)
  * Amazon AWS Access Secret (or place into `AMWS_ACCESS_SECRET` environment variable)
 

## Usage:

1. Clone the repository
2. Run `bundle install`
3. Run `bundle exec ruby lib/cli.rb`
4. Follow directions on screen

## Comments

The library is by no means complete and spec coverage of some parts is sketchy. The basic design seems to be sound and further development path streamlined.
