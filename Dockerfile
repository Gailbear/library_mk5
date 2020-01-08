FROM ruby:2.1.4
RUN apt-get update -qq && apt-get install -y --force-yes build-essential libpq-dev nodejs
RUN mkdir /library_mk5
WORKDIR /library_mk5
COPY Gemfile /library_mk5/Gemfile
COPY Gemfile.lock /library_mk5/Gemfile.lock
# for production like behavior, uncomment the below
# ENV RAILS_ENV production
RUN bundle install
COPY . /library_mk5
# for production deploys, add ENV SECRET_KEY_BASE xxxxx here
# you can make it using rake secret

# monkey patch for PANIC issue
RUN sed -i s/panic/error/g /usr/local/bundle/gems/activerecord-4.1.1/lib/active_record/connection_adapters/postgresql_adapter.rb