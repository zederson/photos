FROM ruby:2.6.5
MAINTAINER Ederson de Lima<edersondelima@gmail.com>

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim nodejs locales yarn postgresql-client
RUN rm -rf /var/lib/apt/lists/*

ENV PHANTOMJS_VERSION 2.1.1
RUN curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
RUN tar -jxvf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs
RUN mv phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin/
RUN rm phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && rm -rf phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin
RUN chmod 755 /usr/local/bin/phantomjs

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"

RUN mkdir -p /var/www/photos

WORKDIR /var/www/photos

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
RUN gem install bundler-audit

COPY . /var/www/photos

EXPOSE 3000
