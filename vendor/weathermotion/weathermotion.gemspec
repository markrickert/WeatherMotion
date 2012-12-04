# -*- encoding: utf-8 -*-
require File.expand_path('../lib/weathermotion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Rickert"]
  gem.email         = ["mjar81@gmail.com"]
  gem.description   = "Yahoo Weather API integration for RubyMotion"
  gem.summary       = "Yahoo Weather API integration for RubyMotion"
  gem.homepage      = "http://github.com/markrickert/weathermotion/"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|lib_spec|features)/})
  gem.name          = "weathermotion"
  gem.require_paths = ["lib"]
  gem.version       = WeatherMotion::VERSION

  # gem.add_dependency 'bubble-wrap', '~> 1.1.4'
end
