FROM node:8.9.4

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    apt-transport-https \
    wget \
    curl \
    unzip

# Java
RUN add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Android SKD
RUN cd /home/node \
    && mkdir .bin \
    && wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
    && unzip sdk-tools-linux-3859397.zip \
    && rm sdk-tools-linux-3859397.zip

RUN export ANDROID_HOME=$HOME/Android/Sdk
RUN export PATH=$PATH:$ANDROID_HOME/tools
RUN export PATH=$PATH:$ANDROID_HOME/platform-tools

# Gradle
ENV GRADLE_VERSION 4.5
RUN cd /usr/lib \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip"

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn

# Prepare paths
RUN mkdir /code

# Add node to sudoers
RUN echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set permissions
RUN chown node:node -R /code

# Instal globlal npm dependencies
RUN npm install -g react-native-cli

USER node
WORKDIR /code
