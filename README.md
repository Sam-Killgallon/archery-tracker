# Track and view Archery Rounds

Setup
------
Copy `.env` to `.env.<environment>` and fill in details

    bundle install
    yarn install
    bundle exec rails db:setup


Tests
-----

Tests are set up to run using rspec and headless chrome.  
* Ensure at least chrome 59 is installed.  
* Install [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/).  

Run tests with:  

    bundle exec rspec
