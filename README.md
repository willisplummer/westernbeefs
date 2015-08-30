to do:
====================


- polymorphic pages that can be associated with articles or stories (which are nested under articles)

- stories scraper for old site

- update scrapers to skip leading `<br>`'s on page content and author bios

- scraper pulled all the `&nbsp`'s but the site doesn't like them. is there a way to automate converting them to something it will accept?

- remove rich text editor (has way too many options, sends way too much info, loads inconsistently) - maybe replace with something that just tracks line breaks, bold, and italics.. this?

- ~~validate author url input begins with http://~~

- ~~save password info in a private file~~

- deploy a beta version of the new site on heroku

wishlist:
====================


- make page count automated or create a drop down to select page numbers based on the page count that you input?

- manual slug overwrite option in article form


setup:
====================
 ```
bundle
cp config/application.example.yml config/application.yml
 ```

(Enter the correct username and password for production in config/application.yml)
 
 ```
rake db:setup
rails s
 ```