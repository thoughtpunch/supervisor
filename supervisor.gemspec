# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'supervisor/version'

Gem::Specification.new do |gem|
  gem.name          = "supervisor"
  gem.version       = Supervisor::VERSION
  gem.authors       = ["Dan Barrett"]
  gem.email         = ["dbarrett83@gmail.com"]
  gem.description   = "Manager for Asynchronous Jobs & Workers"
  gem.summary       = "Manager for Asynchronous Jobs & Workers"
  gem.homepage      = "http://www.github.com/thoughtpunch/supervisor"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency(%q<yaml>)
  gem.add_dependency(%q<sinatra>)
  gem.add_dependency(%q<haml>)
  gem.add_dependency(%q<activerecord>)
  gem.add_dependency(%q<delayed_job>)
  gem.add_dependency(%q<rdoc>)
  gem.add_dependency(%q<bundler>)
  gem.add_dependency(%q<simplecov>)
  gem.add_dependency(%q<rspec>)
end
