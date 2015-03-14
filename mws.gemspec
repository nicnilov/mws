# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mws/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nic Nilov"]
  gem.email         = ["nic@nicnilov.com"]
  gem.description   = %q{A lightweight ruby client for the Amazon MWS API.}
  gem.summary       = %q{A lightweight ruby client for the Amazon MWS API.}
  gem.homepage      = "https://github.com/nicnilov/mws"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mws"
  gem.require_paths = ["lib"]
  gem.version       = Mws::VERSION

  gem.add_dependency 'faraday', '~> 0.9.1'
  gem.add_dependency 'faraday_middleware', '>= 0.9.1'
  gem.add_dependency 'json', ['>= 1.7.5', '< 1.9.0']
  gem.add_dependency 'hashie', ['>= 1.2.0', '< 4.0']

  gem.add_development_dependency 'rspec', '~> 3.2.0'
  gem.add_development_dependency 'rspec-its', '~> 1.2.0'
  gem.add_development_dependency 'simplecov', '~> 0.9.2'
end
