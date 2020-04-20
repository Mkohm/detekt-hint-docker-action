#!/bin/sh -l

echo "Github api token: $1"
time=$(date)
echo "::set-output name=time::$time"

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"


./gradlew assemble
bundle update
bundle install --gemfile=/github/workspace/Gemfile
bundle update danger
bundle exec danger --verbose
