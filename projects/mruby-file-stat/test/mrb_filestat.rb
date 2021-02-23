assert("File::Stat#size") do
  assert_equal(`ruby -e 'puts File.stat("/etc/hosts").size'`.to_i, File::Stat.new("/etc/hosts").size)
end

assert("File::Stat#inode") do
  assert_equal(`ruby -e 'puts File.stat("/etc/hosts").ino'`.to_i, File::Stat.new("/etc/hosts").inode)
end

assert("File::Stat#uid") do
  assert_equal(`ruby -e 'puts File.stat("/etc/hosts").uid'`.to_i, File::Stat.new("/etc/hosts").uid)
end

assert("File::Stat#gid") do
  assert_equal(`ruby -e 'puts File.stat("/etc/hosts").gid'`.to_i, File::Stat.new("/etc/hosts").gid)
end

assert("File::Stat#dev_major") do
  assert_equal(`ruby -e 'puts File.stat("/etc/hosts").dev_major'`.to_i, File::Stat.new("/etc/hosts").dev_major)
end

assert("File::Stat#dev_minor") do
  assert_equal(`ruby -e 'puts File.stat("/etc/hosts").dev_minor'`.to_i, File::Stat.new("/etc/hosts").dev_minor)
end

assert("File::Stat#rdev_major") do
  assert_equal(`ruby -e 'puts File.stat("/dev/null").rdev_major'`.to_i, File::Stat.new("/dev/null").rdev_major)
end

assert("File::Stat#rdev_minor") do
  assert_equal(`ruby -e 'puts File.stat("/dev/null").rdev_minor'`.to_i, File::Stat.new("/dev/null").rdev_minor)
end

# mrubyのtimeはequalが実装されていないっぽいので、数値にして無理やり比較する
assert("File::Stat#mtime") do
  expected = `ruby -e 'puts File.stat("/dev/null").mtime.to_i'`.chomp.to_i
  assert_equal(expected, File::Stat.new("/dev/null").mtime.to_i)
end

assert("File::Stat#file?") do
  assert_equal(true, File::Stat.new("/etc/hosts").file?)
  assert_equal(false, File::Stat.new("/etc").file?)
end

assert("File::Stat#directory?") do
  assert_equal(false, File::Stat.new("/etc/hosts").directory?)
  assert_equal(true, File::Stat.new("/etc").directory?)
end

# RubyのFile::Stat#symlynkは必ずfalseになるらしいので、Rubyを呼び出しての比較は無理。
assert("File::Stat#symlink?") do
  assert_equal(true, File::Stat.new("/bin/vim").symlink?)
  assert_equal(false, File::Stat.new("/dev/null").symlink?)
end

assert("File::Stat#writable") do 
  assert_equal(true, File::Stat.new("/dev/null").writable?)
  assert_equal(false, File::Stat.new("/proc/cmdline").writable?)
end