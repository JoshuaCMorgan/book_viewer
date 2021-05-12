require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"


get "/" do
  @title = "The Adventures of Sherlock Holmes"
  # 'readlines`: Reads the entire file specified by name as individual lines, and returns those lines in an array. 
  @contents = File.readlines("data/toc.txt")

  erb(:home)
end

get "/chapters/1" do
  @title = "Chapter 1"
  @contents = File.readlines("data/toc.txt")
  @chapter = File.read("data/chp1.txt")

  erb(:chapter)
end
