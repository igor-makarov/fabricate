# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fabricate/version'

Gem::Specification.new do |spec|
  spec.name          = File.basename(__FILE__, '.gemspec')
  spec.version       = Fabricate::VERSION
  spec.authors       = ["Igor Makarov"]
  spec.email         = ["igormaka@gmail.com"]

  spec.summary       = "Fabricate"
  spec.description   = "A gem that uploads dSYM files to fabric. OS-independent and can be used on linux"
  spec.homepage      = "https://github.com/igor-makarov/fabricate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '>= 0.9'
  spec.add_dependency 'oga'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
