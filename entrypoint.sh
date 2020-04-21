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

# Will always return a successfull exit code, making PRs from forks also succeed. However, because of this bug https://github.com/danger/danger/issues/1103 Danger will not run. When the bug is fixed, the command can be run as normally.
bundle exec danger --verbose --dangerfile=/Dangerfile || true
