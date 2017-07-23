# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'giphy_api/version'

Gem::Specification.new do |spec|
  spec.name          = "giphy_api"
  spec.version       = GiphyApi::VERSION
  spec.authors       = ["Farrukh Abdulkadyrov"]
  spec.email         = ["farrukhabdul@gmail.com"]

  spec.summary       = 'Minimalistic Ruby Wrapper for Giphy API'
  spec.homepage      = "https://gihtub.com/faragorn/giphy_api"
  spec.license       = "MIT"
  spec.required_ruby_version = '~> 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "fakeweb",  "~> 1.3"
  spec.add_development_dependency "byebug", "~> 9.0"
  spec.add_development_dependency "codecov", "~> 0.1"
end
