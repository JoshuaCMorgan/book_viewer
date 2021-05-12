require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  File.read("public/file-server.html")
end