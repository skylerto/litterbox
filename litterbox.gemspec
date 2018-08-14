
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'litterbox/version'

Gem::Specification.new do |spec|
  spec.name          = 'litterbox'
  spec.version       = Litterbox::VERSION
  spec.authors       = ['skylerto']
  spec.email         = ['skylerclayne@gmail.com']

  spec.summary       = 'Some of the bits around the edge of Habitat'
  spec.description   = <<-DESC
  Some of the bits around the edge of Habitat, that I wish were available natively.
  DESC
  spec.homepage      = 'https://github.com/skylerto/litterbox'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rake'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubyzip'
  spec.add_development_dependency 'yard'
  spec.add_dependency 'thor'
  spec.add_dependency 'toml'
end
