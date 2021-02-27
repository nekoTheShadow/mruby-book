MRuby::Gem::Specification.new('mruby-unsafe_code') do |spec|
  
  spec.license = 'MIT'
  spec.authors = 'hajime nakamura'

  spec.cc.defines << "_FORTIFY_SOURCE=0"
  spec.cc.flags << "-fno-stack-protector"
end
