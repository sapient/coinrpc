lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coinrpc/version'

Gem::Specification.new do |spec|
  spec.name          = "coinrpc"
  spec.version       = CoinRPC::VERSION
  spec.authors       = ["Atif Nazir"]
  spec.email         = ["a@block.io"]
  spec.summary       = %q{A fast RPC client for Bitcoin Core style software.}
  spec.description   = %q{This Ruby Gem is a fast RPC client for Bitcoin Core style software, including Dogecoin, Litecoin, and other similar software that implements Bitcoin Core RPC interfaces.}
  spec.homepage      = "https://github.com/doersf/coinrpc"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.required_ruby_version = ">= 2.4", "< 3.0"
  
  spec.add_development_dependency "bundler", "~> 1.6", ">= 1.6", "< 3.1"
  spec.add_development_dependency "rake", '~> 13.0', ">= 13.0", "< 14.0"
  spec.add_runtime_dependency "oj", "~> 3.10.6", ">= 3.10", "< 4.0"
  spec.add_runtime_dependency "http", "~> 4.4.1", ">= 4.4.1", "< 5.0"
end
