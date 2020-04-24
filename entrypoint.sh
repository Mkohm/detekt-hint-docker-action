#!/bin/bash

echo "::set-env name=DANGER_GITHUB_API_TOKEN::$1"


export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
source /etc/environment
echo "New java home:"
echo $JAVA_HOME

yes | apt install curl


bash <(curl -s https://raw.githubusercontent.com/danger/kotlin/master/scripts/install.sh)
source ~/.bash_profile

# Build artifacts
./gradlew assemble

# Run detekt hint to generate the warning report
./gradlew detektHint

# Run danger/kotlin
danger-kotlin ci

