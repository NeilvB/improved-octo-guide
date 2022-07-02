FROM ruby:3.1.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
 build-essential libpq-dev nodejs zlib1g-dev liblzma-dev yarn

WORKDIR /app

# copy Gemfile and Gemfile.lock and install gems before copying rest of the application
# so the steps will be cached until there won't be any changes in Gemfile
COPY Gemfile* ./
RUN bundle install

COPY . .

# precompile assets with temporary secret key base
RUN SECRET_KEY_BASE="assets_compile" RAILS_ENV=production bundle exec rake assets:precompile

CMD bundle exec rails server --port=3000 --binding='0.0.0.0'