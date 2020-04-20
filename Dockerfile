# Container image that runs your code
FROM ubuntu:18.04

# Install git
RUN apt update
RUN yes | apt install git

RUN yes | apt install default-jdk
Run yes | apt-get install ruby-full

RUN apt-get install ruby-dev

RUN gem install bundler
RUN bundle install

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

