# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'nanosemantic/version'

Gem::Specification.new do |spec|
  spec.name          = "nanosemantic"
  spec.version       = "0.0.1"
  spec.authors       = ["Kosechok"]
  spec.email         = ["kosechok@gmail.com"]
  spec.summary       = "Chats statistic"
  spec.description   = "Api of inf's statistic "
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
