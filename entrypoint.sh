#!/bin/sh -l

echo "Github api token: $1"
time=$(date)
echo "::set-output name=time::$time"

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"

echo "Github Workspace is: $GITHUB_WORKSPACE"
ls /github/workspace/
echo "Github Home is: $HOME"
ls /github/home/


./gradlew assemble
bundle update
bundle install
bundle update danger
bundle exec danger --verbose
