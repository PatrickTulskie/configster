# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'configster/version'

Gem::Specification.new do |gem|
  gem.name          = "configster"
  gem.version       = Configster::VERSION
  gem.authors       = ["Patrick Tulskie"]
  gem.email         = ["patricktulskie@gmail.com"]
  gem.description   = %q{Configster is a tidy little configuration management utility for your application.  Store your configuration as YAML outside of your application.  You probably haven't heard of it.}
  gem.summary       = %q{Configster keeps your configuration out of your application.}
  gem.homepage      = "https://github.com/PatrickTulskie/configster"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('ZenTest')
  
end
