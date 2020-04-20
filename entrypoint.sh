#!/bin/sh -l

echo "Github api token: $1"
time=$(date)
echo "::set-output name=time::$time"

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"

git clone --depth=50 --branch=master https://github.com/Mkohm/detekt.git Mkohm/detekt
./gradlew assemble
apt-get install build-essential patch
apt-get install ruby-dev zlib1g-dev liblzma-dev
bundle update
bundle install
bundle update danger
bundle exec danger --verbose
