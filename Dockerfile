FROM ruby:3.0.3

ENV NODE_VERSION 16
ENV INSTALL_PATH /opt/app

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nodejs postgresql-client \
      locales yarn

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY . $INSTALL_PATH