#!/bin/sh -l

echo "Github api token: $1"
time=$(date)
echo "::set-output name=time::$time"

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"

echo "Github Workspace is: $GITHUB_WORKSPACE"
ls /github/workspace/
echo "Github Home is: $HOME"
ls /github/home/
echo "root dir:"
ls /
echo "build dir:"
ls /github/workspace/build

echo "java version"
java -v
echo "java home variable"
echo $JAVA_HOME
echo "javapath"
ls /usr/lib/jvm/
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
source /etc/environment
echo "new java home:"
echo $JAVA_HOME

./gradlew assemble
bundle update
bundle install --gemfile=/Gemfile
bundle update danger
bundle exec danger --verbose --dangerfile=/Dangerfile
