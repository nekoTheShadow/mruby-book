anp = Apache::AuthnProvider.new
chars = anp.user.chars

if chars.any?{|c| !("a".."z").to_a.include?(c)}
  Apache.return Apache::AuthnProvider::AUTH_DENIED
end

if chars.map{|c| (123 + (96 - c.ord)).chr}.join == anp.password
  Apache.return Apache::AuthnProvider::AUTH_GRANTED
else
  Apache.return Apache::AuthnProvider::AUTH_DENIED
end 