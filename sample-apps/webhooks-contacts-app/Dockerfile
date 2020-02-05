FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y mariadb-client nodejs
RUN mkdir /hubspot-api-ruby

COPY ./lib /hubspot-api-ruby/lib
COPY ./sample-apps /hubspot-api-ruby/sample-apps
COPY ./Gemfile /hubspot-api-ruby/Gemfile
COPY ./Gemfile.lock /hubspot-api-ruby/Gemfile.lock
COPY ./hubspot-api-ruby.gemspec /hubspot-api-ruby/hubspot-api-ruby.gemspec

WORKDIR /hubspot-api-ruby/sample-apps/webhooks-contacts-app
RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./sample-apps/webhooks-contacts-app/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]