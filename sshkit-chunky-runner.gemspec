# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sshkit/chunky/runner/version'

Gem::Specification.new do |spec|
  spec.name          = 'sshkit-chunky-runner'
  spec.version       = SSHKit::Chunky::Runner::VERSION
  spec.authors       = ['Tomas Brazys']
  spec.email         = ['tomas.brazys@gmail.com']
  spec.summary       = 'Run ssh commands in chunks'
  spec.description   = 'Runs ssh commands in few chunks. It divides hosts into \
                        static number of chunks, you just need to specify how \
                        many chunks you need.'
  spec.homepage      = 'https://github.com/deees/sshkit-chunky-runner'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'sshkit', '~> 1.0.0'
end
