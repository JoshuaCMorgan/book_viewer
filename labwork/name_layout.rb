require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"


#This could will look for name-layout.erb in views folder.  Easy fix would be to change that file name or remove it. 
# get "/:name" do
#   erb("<html><body><h1>Hello, <%= name %>!</h1></body></html>", {:locals => {:name => params[:name]}})
#   # {:locals => params} will shorten it.
# end


#This could will look for name-layout.erb in views folder.  Easy fix would be to change that file name or remove it. 
# get '/:name' do
#   template = "<h1>Hello, <%= name %>!</h1>"
#   this_layout   = "<html><body><%= yield %></body></html>"
#   erb(template, { :locals => params, :layout => this_layout })
# end

get '/:name' do 
  erb(:name_layout, {:locals => params, :layout => :layout})
  # shortened
  # erb(:name_layout, {:locals => params})
end
