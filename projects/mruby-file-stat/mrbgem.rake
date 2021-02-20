MRuby::Gem::Specification.new('mruby-file-stat') do |spec|
  
  spec.license = 'MIT'
  spec.authors = 'hajime nakamura'

  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-errno'
  spec.add_dependency 'mruby-time'
end
