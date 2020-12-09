FROM ruby:2.7.2

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile* /app/

RUN bundle install 

ADD . /app/

CMD ["ruby", "pipe.rb"]