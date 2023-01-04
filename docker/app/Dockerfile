FROM ruby:2.6.1

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg
RUN cat pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-key update
RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends build-essential libpq-dev nodejs yarn less ruby-dev \
    zlib1g-dev \
    default-mysql-client \
    liblzma-dev \
    libmariadb-dev
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN gem install bundler -v 2.3.6

WORKDIR /app
