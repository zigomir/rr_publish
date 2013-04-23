# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rr_publish/version'

Gem::Specification.new do |spec|
  spec.name          = 'rr_publish'
  spec.version       = RRPublish::VERSION
  spec.authors       = ['Winton Welsh', 'Žiga Vidic']
  spec.email         = ['mail@wintoni.us, zigomir@gmail.com']
  spec.description   = %q{Ruby and Rsync}
  spec.summary       = %q{Ruby and Rsync}
  spec.homepage      = 'http://github.com/zigomir/rr_publish'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
