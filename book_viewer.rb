require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

before do
  @contents = File.readlines("data/toc.txt")
end

helpers do

  def in_paragraphs(text)
    text.split("\n\n").map.with_index do |paragraph, index|
      "<p id='paragraph#{index + 1}'>#{paragraph}</p>"
    end.join
  end

  def highlight(text, term)
    text.gsub(term, "<strong>#{term}</strong>")
  end

end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  # 'readlines`: Reads the entire file specified by name as individual lines, and returns those lines in an array. 
  
  erb(:home)
end

get "/search" do
  @results = chapter_matches(params[:query])

  erb(:search)
end


get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @contents[number - 1]

  # Will handle user trying to access a non-existent book chapter or specify a non-number value where the chapter number should be.
  redirect "/" unless (1..@contents.size).cover?(number)

  @title = "Chapter #{number}: #{chapter_name}"
  @chapter = File.read("data/chp#{number}.txt")

  erb(:chapter)
end


not_found  do
  redirect "/"
end

def each_chapter
  @contents.each_with_index do |name, index|
    number = index + 1
    ch_contents = File.read("data/chp#{number}.txt")
    yield number, name, ch_contents
  end
end

def chapter_matches(query)
  results = []
  return results if !query || query.empty?

  each_chapter do |number, name, ch_contents|
    matches = {}
    ch_contents.split(/\n\n/).each_with_index do |paragraph, index|
       if paragraph.include?(query)
        matches[index] = paragraph
       end
    end

    results << {number: number, name: name, paragraphs: matches} if matches.any?
  end
  results
end


