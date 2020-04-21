#!/bin/sh -l

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"


export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
source /etc/environment
echo "New java home:"
echo $JAVA_HOME

./gradlew assemble
bundle update
bundle install --gemfile=/Gemfile
bundle update danger
bundle exec danger --verbose --dangerfile=/Dangerfile
