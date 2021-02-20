MRuby::Gem::Specification.new('mruby-first_c') do |spec|
  
  spec.license = 'MIT'
  spec.authors = 'hajime nakamura'

  spec.add_test_dependency 'mruby-io', core: 'mruby-io'
end
