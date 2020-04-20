# Container image that runs your code
FROM ubuntu:18.04

# Install git
RUN apt update
RUN yes | apt install git

RUN yes | apt install default-jdk
RUN yes | apt install ruby-full
RUN yes | apt install build-essential
RUN apt-get install ruby-dev

RUN gem install ruby-ll
RUN gem install bundler


RUN yes | apt-get install build-essential patch
RUN yes | apt-get install ruby-dev zlib1g-dev liblzma-dev

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY Dangerfile /github/home/Dangerfile
COPY Gemfile /github/home/Gemfile

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

