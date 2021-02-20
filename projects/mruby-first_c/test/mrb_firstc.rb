assert("FirstC#my_uname") do
  assert_equal(`uname -n`.chomp, FirstC.my_uname)
end

assert("FirstC#my_stat_size") do
  assert_equal(`stat --printf "%s" /etc/hosts`.to_i, FirstC.my_stat_size("/etc/hosts"))
  assert_raise(Errno::ENOENT) { FirstC.my_stat_size("/path/to/not_found") }
end
