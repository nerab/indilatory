# -*- encoding: utf-8 -*-
require File.expand_path('../lib/indilatory/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nicholas E. Rabenau"]
  gem.email         = ["nerab@gmx.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "indilatory"
  gem.require_paths = ["lib"]
  gem.version       = Indilatory::VERSION

  gem.add_dependency 'ddd-associations'
  gem.add_dependency 'activesupport', '~> 3.2'
  gem.add_dependency 'multi_json'

  gem.add_development_dependency 'guard-minitest', '~> 0.5'
  gem.add_development_dependency 'guard-bundler', '~> 1.0'
  gem.add_development_dependency 'coolline', '~> 0.3'
  gem.add_development_dependency 'growl'

  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'pry'
end
