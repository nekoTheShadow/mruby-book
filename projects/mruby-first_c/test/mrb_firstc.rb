assert("FirstC#my_uname") do
  assert_equal(`uname -n`.chomp, FirstC.my_uname)
end

