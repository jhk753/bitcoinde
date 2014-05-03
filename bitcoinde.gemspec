# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitcoinde/version'

Gem::Specification.new do |spec|
  spec.name          = "bitcoinde"
  spec.version       = BitcoindeRuby::VERSION
  spec.authors       = ["Julien Hobeika"]
  spec.email         = ["julien.hobeika@gmail.com"]
  spec.description   = %q{"Public data of bitcoin.de Exchange"}
  spec.summary       = %q{"Public data of bitcoin.de Exchange"}
  spec.homepage      = "https://github.com/jhk753/bitcoinde"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "httparty"
  spec.add_dependency "hashie"
  spec.add_dependency "addressable"
end