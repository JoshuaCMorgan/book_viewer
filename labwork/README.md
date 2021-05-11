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
[template-router.rb](template-router.rb)
- This application is acting as a static file server
- We are moving from working within one file [simple-router.rb](simple-router.rb) to seperating out our concerns by creating for ourselves a seperate file location where we can store code.
- we're loading the contents of the file at "public/template.html" and sending it back to the browser.
  - `File.read` will return a string, which is what form the browser needs.

# Dynamic app that renders a template to the browser