# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cimis/version'

Gem::Specification.new do |spec|
  spec.name          = "cimis-ruby"
  spec.version       = Cimis::VERSION
  spec.authors       = ["dphaener"]
  spec.email         = ["dphaener@gmail.com"]

  spec.summary       = %q{A Ruby wrapper for the CIMIS data API}
  spec.description   = %q{A Ruby wrapper for the CIMIS data API}
  spec.homepage      = "https://github.com/EditLLC/cimis-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "shoulda-context", "~> 1.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "json", "~> 1.8"
  spec.add_dependency "virtus", "~> 1.0"
end
