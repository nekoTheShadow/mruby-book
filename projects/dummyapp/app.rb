require "sinatra"

get "/" do
  "Hello, application! Number: #{ENV['APP_NUMBER']}\n"
end