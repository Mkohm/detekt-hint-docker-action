#!/bin/sh -l

echo "Github api token: $1"
time=$(date)
echo "::set-output name=time::$time"

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"

echo "Github Workspace is: $GITHUB_WORKSPACE"
echo "ls $GITHUB_WORKSPACE"
echo "Github Home is: $HOME"
echo "ls $HOME"


./gradlew assemble
bundle update
bundle install
bundle update danger
bundle exec danger --verbose
