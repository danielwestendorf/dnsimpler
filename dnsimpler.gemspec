# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dnsimpler/version'

Gem::Specification.new do |spec|
  spec.name          = "dnsimpler"
  spec.version       = DNSimpler::VERSION
  spec.authors       = ["Daniel Westendorf"]
  spec.email         = ["daniel@prowestech.com"]
  spec.summary       = %q{A simple DNSimple API wrapper that always provides the response you're looking for.}
  spec.description   = %q{dnsimple-ruby is too opinionated on how to use its method calls. We're all capable devs, righ? Let's just use the API like a developer would.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version  = "~> 2.0"

  spec.add_runtime_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "webmock"
end
