FROM ruby:2.7

RUN gem install sinatra
COPY app.rb /app.rb
EXPOSE 4567

CMD ["ruby", "/app.rb", "-o", "0.0.0.0"]