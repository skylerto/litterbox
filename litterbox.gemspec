
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
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16.1'
  spec.add_development_dependency 'guard', '~> 2.14.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.52.1'
end
