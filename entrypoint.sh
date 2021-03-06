#!/bin/bash
echo "ls"
ls
echo "pwd"
pwd

# Run detekt hint
./gradlew detektHint

# Install danger-kotlin
bash <(curl -s https://raw.githubusercontent.com/danger/kotlin/master/scripts/install.sh)
source ~/.bash_profile

npx --package danger danger-kotlin ci --dangerfile /Dangerfile.df.kts
