FROM gradle:5.6.2-jdk8

MAINTAINER Franco Meloni

LABEL "com.github.actions.name"="Danger Kotlin"
LABEL "com.github.actions.description"="Runs Kotlin Dangerfiles"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="blue"

# Install dependencies
RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs make zip

RUN cd /usr/lib && \
    wget -q https://github.com/JetBrains/kotlin/releases/download/v1.3.70/kotlin-compiler-1.3.70.zip && \
    unzip kotlin-compiler-*.zip && \
    rm kotlin-compiler-*.zip

ENV PATH $PATH:/usr/lib/kotlinc/bin

# Install danger-kotlin globally
#COPY . _danger-kotlin

# Install danger-kotlin
RUN /bin/bash -c "<(curl -s https://raw.githubusercontent.com/danger/kotlin/master/scripts/install.sh)"
RUN /bin/bash -c "source ~/.bash_profile"

COPY Dangerfile.df.kts /Dangerfile.df.kts
COPY entrypoint.sh /entrypoint.sh

#RUN cd _danger-kotlin && make install

# Run Danger Kotlin via Danger JS, allowing for custom args
ENTRYPOINT ["/entrypoint.sh"]
