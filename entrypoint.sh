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


./gradlew assemble
bundle update
bundle install --gemfile=/github/home/Gemfile
bundle update danger
bundle exec danger --verbose --dangerfile=/github/home/Dangerfile
