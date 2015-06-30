# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','syclink','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'syclink'
  s.version = SycLink::VERSION
  s.author = 'Pierre Sugar'
  s.email = 'pierre@sugaryourcoffee.de'
  s.homepage = 'https://github.com/sugaryourcoffee/syclink'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Create  a link list and display it in a HTML file'
  s.files = `git ls-files`.split(" ")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','test.rdoc']
  s.rdoc_options << '--title' << 'test' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'syclink'
  s.add_development_dependency('rspec')
  s.add_development_dependency('sass')
  s.add_runtime_dependency('gli','2.13.1')
end
