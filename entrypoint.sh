#!/bin/sh -l

echo "Github api token: $1"
time=$(date)
echo "::set-output name=time::$time"

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"



./gradlew assemble
gem install bundler
bundle install
bundle update danger
bundle exec danger --verbose