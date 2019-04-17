# Track and view Archery Rounds

Source code for archery tracker app

## Setup

    docker-compose build
    # Setup the database
    docker-compose run --rm web rails db:setup
    # Run tests to ensure everything is working
    docker-compose run --rm web rspec
    # Generate the pdfs score sheets
    docker-compose run --rm rails rounds:pdf
    docker-compose up

Visit `localhost:3000`
Run `docker-compose down` to shut down the app
