def check(method_name, path, ruby_method_name: nil, memo: nil)
  msg = memo.nil? ? "File::Stat##{method_name}" : "File::Stat##{method_name} (#{memo})"
  assert(msg) do 
    expected = `ruby -e 'puts File::Stat.new("#{path}").#{ruby_method_name || method_name}'`.chomp
    actual = File::Stat.new(path).__send__(method_name).to_s
    assert_equal(expected, actual)
  end
end

check("size", "/etc/hosts")
check("inode", "/etc/hosts", ruby_method_name: "ino")
check("uid", "/etc/hosts")
check("gid", "/etc/hosts")
check("dev_major", "/etc/hosts")
check("dev_minor", "/etc/hosts")
check("rdev_major", "/dev/null")
check("rdev_minor", "/dev/null")
check("file?", "/etc/hosts", memo: "return true if target is a regular file.")
check("file?", "/etc", memo: "return false if target is not a regular file.")
check("directory?", "/etc/hosts", memo: "return false if target is not a directory.")
check("directory?", "/etc", memo: "return true if target is a directory.")
check("mtime", "/etc/hosts")

# RubyのFile::Stat#symlynkは必ずfalseになるらしいので、
# checkメソッドではテストできない。
assert("File::Stat#symlink?") do
  assert_equal(true, File::Stat.new("/bin/vim").symlink?)
  assert_equal(false, File::Stat.new("/dev/null").symlink?)
end

assert("File::Stat#writable") do 
  assert_equal(true, File::Stat.new("/dev/null").writable?)
  assert_equal(false, File::Stat.new("/proc/cmdline").writable?)
end