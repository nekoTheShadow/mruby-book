# mruby-file-stat   [![Build Status](https://travis-ci.org/nakamura0903/mruby-file-stat.svg?branch=master)](https://travis-ci.org/nakamura0903/mruby-file-stat)
FileStat class
## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'nakamura0903/mruby-file-stat'
end
```
## example
```ruby
p FileStat.hi
#=> "hi!!"
t = FileStat.new "hello"
p t.hello
#=> "hello"
p t.bye
#=> "hello bye"
```

## License
under the MIT License:
- see LICENSE file
