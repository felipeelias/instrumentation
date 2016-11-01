# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instrumentation/version'

Gem::Specification.new do |spec|
  spec.name          = 'instrumentation'
  spec.version       = Instrumentation::VERSION
  spec.authors       = ['Felipe Philipp']
  spec.email         = ['felipeelias@gmail.com']

  spec.summary       = 'Monitor process stats over time'
  spec.description   = 'Monitor process memory and CPU over time'
  spec.homepage      = 'https://github.com/felipeelias/instrumentation'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 11.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'rack', '2.0.1'
end
