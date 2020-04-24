# Container image that runs your code
FROM ubuntu:18.04

RUN apt update
RUN yes | apt install git

RUN yes | apt install default-jdk

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY Dangerfile.df.kts /Dangerfile.df.kts


# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

