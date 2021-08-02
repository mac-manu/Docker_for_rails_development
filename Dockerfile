FROM ruby:2.7

# The qq is for silent output in the console
RUN apt-get update -qq && \
    apt-get install -y build-essential openssl libssl-dev nodejs less vim libsasl2-dev


# Sets the path where the app is going to be installed
# you can modify this as you wish
ENV WORK_ROOT /var
ENV RAILS_ROOT $WORK_ROOT/www/
ENV LANG C.UTF-8
ENV GEM_HOME $WORK_ROOT/bundle
ENV BUNDLE_BIN $GEM_HOME/gems/bin
ENV PATH $GEM_HOME/bin:$BUNDLE_BIN:$PATH

RUN gem install bundler -v 2.1.4 
# Creates the directory and all the parents (if they don't exist)
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

COPY Gemfile ./

# Installs the Gem File.
RUN bundle install

# We copy all the files from the current directory to our
# application directory
COPY . $RAILS_ROOT

# Installs the Gem File.
RUN bundle install

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
