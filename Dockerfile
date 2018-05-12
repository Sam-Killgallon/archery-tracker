FROM ruby:2.5

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -yf nodejs yarn build-essential locales

RUN locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

ENV RAILS_ENV=production

RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4

COPY package.json yarn.lock ./
RUN yarn install --pure-lockfile

# Copy the main application.
COPY . ./

# Expose port 80 to the Docker host, so we can access it
# from the outside.
EXPOSE 80

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-p", "80", "-b", "0.0.0.0"]
