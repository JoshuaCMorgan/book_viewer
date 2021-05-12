require "sinatra"
require "sinatra/reloader"

get "/" do
  File.read("public/file-server.html")
end