# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'halfday/version'

Gem::Specification.new do |spec|
  spec.name          = "halfday"
  spec.version       = Halfday::VERSION
  spec.authors       = ["Samuel Garneau"]
  spec.email         = ["sgarneau@mirego.com"]
  spec.description   = %q{All you need to deploy on our internal infrastructure}
  spec.summary       = %q{All you need to deploy on our internal infrastructure}
  spec.homepage      = "https://github.com/mirego/halfday"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
