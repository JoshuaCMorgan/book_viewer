# Labwork for learning Sinatra

# How Routes Work in Sinatra
Sinatra makes it easy to write Ruby code that runs when a user visits a particular URL.
[Simple-router.rb](simple-router.rb)
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