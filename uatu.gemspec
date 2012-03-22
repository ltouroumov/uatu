Gem::Specification.new do |spec|
  spec.name = 'uatu'
  spec.version = '0.5.1'
  spec.date = '2012-03-21'

  spec.author = 'Jeremy David'
  spec.email = 'uatu@jeremydavid.ch'

  spec.summary = %q{
    Script trigger upon changes
  }
  spec.description = %q{
    A simple gem to trigger a script upon file system change
  }
  spec.homepage = 'http://github.com/ltouroumov/uatu'

  spec.add_runtime_dependency 'fssm', '>= 0.2.8.1'

  spec.files = ['bin/uatu', 'lib/uatu.rb']
  spec.executables = ['uatu']
  spec.require_paths = ['lib']
end