# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fantassh/version'

Gem::Specification.new do |spec|
  spec.name          = 'fantassh'
  spec.version       = Fantassh::VERSION
  spec.authors       = ['Alexis Reigel']
  spec.email         = ['mail@koffeinfrei.org']
  spec.description   = 'Quickly connect to your ssh history.'
  spec.summary       = 'Provides a selectable history list for quickly accessing your past ssh connections.'
  spec.homepage      = 'https://github.com/koffeinfrei/fantassh'
  spec.license       = 'GPL-3.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
