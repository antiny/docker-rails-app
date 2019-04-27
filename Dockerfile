FROM ruby:2.6

LABEL maintainer="tranminhan.my@gmail.com"

# allow apt to work with https-based resources
RUN \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends nodejs yarn


COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"] 