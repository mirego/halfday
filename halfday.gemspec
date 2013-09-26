# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'halfday/version'

Gem::Specification.new do |spec|
  spec.name          = "halfday"
  spec.version       = Halfday::VERSION
  spec.authors       = ["Samuel Garneau"]
  spec.email         = ["sgarneau@mirego.com"]
  spec.description   = %q{Collection of Capistrano recipes - Deploy. Then, take a halfday.}
  spec.summary       = %q{Collection of Capistrano recipes - Deploy. Then, take a halfday.}
  spec.homepage      = "https://github.com/mirego/halfday"
  spec.license       = 'BSD 3-Clause'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "capistrano"
  spec.add_dependency "capistrano-ext"

  spec.add_dependency "foreman"
end
