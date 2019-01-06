# Track and view Archery Rounds

Source code for archery tracker app

Setup
------

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

Todo
-----

* Add user accounts to submit scores
* Generate pdf score sheets for printing
* Add page for bow tuning
* Add support for bows other than recurve
