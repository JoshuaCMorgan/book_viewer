# When a user visits the path on the application, Sinatra will execute the body of the block. 
# The value that is returned by the block is then sent to the user's browser.

require "sinatra"
require "sinatra/reloader"

get "/" do
  "Hello World!"
end
