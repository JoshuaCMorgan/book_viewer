# Labwork for learning Sinatra

# How Routes Work in Sinatra
Sinatra makes it easy to write Ruby code that runs when a user visits a particular URL.

[simple-router.rb](simple-router.rb)
-  When a user visits the path on the application, Sinatra will execute the body of the block. 
-  The value that is returned by the block is then sent to the user's browser.
-  Here, we print "Hello World!" to the browser screen.
-  When you run the program `bundle exec ruby simple-route.rb` and visit the page `http://localhost/4567/`
   -  Sinatra allow the browsers to produce
  ```ruby 
  <html>
    <head>
      <style type="text/css">/* I removed css code */</style>
    </head>
    <body>
      Hello World!
    </body>
  </html>
  ```
# Serve a static website & seperate our concerns
[file-server.rb](file-server.rb)
- This application is acting as a static file server
- We are moving from working within one file [simple-router.rb](simple-router.rb) to seperating out our concerns by creating for ourselves a seperate file location ([file-server.html](public/file-server.html) where we can store code.
- we're loading the contents of the file at "public/template.html" and sending it back to the browser.
  - `File.read` will return a string, which is what form the browser needs.

# Dynamic app that renders a template to the browser
[dynamic-router.rb](dynamic-router.rb)
- We use ERB has our templating language.  ERB  will allow us to embed dynamic values defined in Ruby code, insert it into the template, and convert it to 100% HTML.
- In this case, we add a dynamic value to the page.
  - We defined the value in the `get "/"` route.
  - We call the `erb` method and pass in as our argument the file we want it to work with.  
- When run, we should see a simple web page that gives us the title and tells us the title in the body.

# Sinatra and Layouts
Redundancy is not fun.  If I do an activity/action three times, I'll probably do it more.  Therefore, I should probably find a way to automate that activity.  For instance, it's common to have a script that types out the fundamental structure of HTML code that goes into every HTML doc you create. I have something like that.  If I type ";html", I get in return:
```html 
<!DOCTYPE html>
<html lang="en-US">

  <head>
    <title>your page title goes here</title>
    <meta charset="utf-8" />
  </head>

  <body>
  </body>
</html>
```

Well, Sinatra has something like this when working with ERB.  ERB will allow us to embed Ruby code inside HTML.  Nice.  But, it would be nice if we didn't have to write all the same code over again for each ERB view template we create.  It would be nice if we could create one layout template that we can repeatably use in whatever ERB view template. It would be nice to extract the redundant code from our ERB view templates and use that one layout for all of them. 

Let's look at an example.
```ruby
get "/:name" do
  erb("<html><body><h1>Hello, <%= name %>!</h1></body></html>", {:locals => {:name => params[:name]}})
  # {:locals => params} will shorten it.
end
```
Here is a route that takes a query parameter and prints a hello message to the client's browswer.  If we use just ERB, above is what it would look like.  You'll notice, though, the redundancy of the HTML code.  Every time we want to display something to the user, we would need to type out this redundant code.  Sinatra helps with layouts. Here's what it looks like:
```ruby
get '/:name' do
  erb_template = "<h1>Hello, <%= name %>!</h1>"
  sinatra_layout = "<html><body><%= yield %></body></html>"
  erb(erb_template, { :locals => params, :layout => sinatra_layout })
end
```
For ease of eyes, we've set the code to variables.  We've passed the particular code unique to this route, `erb_template`, to the `erb` method.  We've also created our Sinatra layout, which we can use over and over, saved it to a variable and passed it in to `erb` along with the parameters.  

Like magic, Sinatra will wrap the layout around the ERB view template.  If you run this code and access it via url `http://localhost:4567/josh` and look at the source code you will see: 
```html
<html>
  <head>
    <style type="text/css">/* code removed */</style>
  </head>
  <body>
    <h1>Hello, josh!</h1>
  </body>
</html
```
Sinatra has wrapped the layout template around the ERB view template. Nice. 
You'll notice `<%= yield %>`. `yield` is a keyword that will call a block if one is given to the method.  So, you can infer that Sinatra puts the ERB view template in a block and calls it with its time to insert the code in its layout template. For our purpose, we see that this is the place where our ERB template is inserted.

## Layouts in files
[name_layout.rb](name_layout.rb)
[views/name_layout.erb](views/name_layout.erb)
[views/layout.erb](views/layout.erb)
Now, we can seperate our concerns by putting our layout template in its own file like we would with our ERB view templates. We can store it in our "views" folder and give it `.erb` file type name. I've put the erb template in its own file `name_layout.erb`. We may also want to tell Sinatra that we have a layout for ut to use.  We can put that in our hash along with the local parameters. Now, our route looks like this:
```ruby
get '/:name' do 
  erb(:name_layout, {:locals => params, :layout => :layout})
end
```
Sinatra will look for a layout called `layout.erb` in the views directory and use this to wrap the `name_layout.erb` template.
