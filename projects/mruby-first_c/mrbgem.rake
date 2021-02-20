MRuby::Gem::Specification.new('mruby-first_c') do |spec|
  
  spec.license = 'MIT'
  spec.authors = 'hajime nakamura'

  spec.add_dependency 'mruby-errno'
  spec.add_test_dependency 'mruby-io'
end
