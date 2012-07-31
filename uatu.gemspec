Gem::Specification.new do |spec|
  spec.name = 'uatu'
  spec.version = '0.6.1'
  spec.date = '2012-07-31'

  spec.author = 'Jeremy David'
  spec.email = 'uatu@jeremydavid.ch'

  spec.summary = %q{
    Script trigger upon changes
  }
  spec.description = %q{
    A simple gem to trigger a script upon file system change
  }
  spec.homepage = 'http://github.com/ltouroumov/uatu'

  spec.add_runtime_dependency 'listen', '~> 0.4.7'

  spec.files = ['bin/uatu', 'lib/uatu.rb']
  spec.executables = ['uatu']
  spec.require_paths = ['lib']
end