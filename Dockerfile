from ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive 
ENV JAVA_HOME  /usr/lib/jvm/java-8-openjdk-amd64
ENV MAVEN_HOME /usr/share/maven
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 7.7.4
ENV YARN_VERSION 0.21.3

RUN apt-get update && apt-get install -y wget bzip2 linux-headers-4.4.0-22-generic dkms xfce4 \
                                         vnc4server openssl libgstreamer-plugins-base0.10-dev \
                                         libxcomposite-dev libxslt1.1 default-jdk openssh-client \
                                         maven git android-tools-adb android-tools-fastboot \
    && echo deb http://download.virtualbox.org/virtualbox/debian xenial contrib >> /etc/apt/sources.list.d/virtualbox.list \
    && wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - \
    && wget -P /tmp https://dl.genymotion.com/releases/genymotion-2.8.1/genymotion-2.8.1_x64.bin \
    && chmod +x /tmp/genymotion-2.8.1_x64.bin \
    && apt-get update \
    && apt-get install -y virtualbox-5.1 \
    && echo 'Y' | /tmp/genymotion-2.8.1_x64.bin \
    && ln -s /opt/genymobile/genymotion/genymotion /usr/bin/genymotion \
    && ln -s /opt/genymobile/genymotion/genymotion-shell /usr/bin/genymotion-shell \
    && ln -s /opt/genymobile/genymotion/gmtool /usr/bin/gmtool \
    && ln -s /opt/genymobile/genymotion/player /usr/bin/player \
    && apt-get clean \
    && groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node \
    && set -ex \
    && for key in \
      9554F04D7259F04124DE6B476D5A82AC7E37093B \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      56730D5401028683275BD23C23EFEFE93C4CFFFE \
      6A010C5166006599AA17F08146C2130DFD2497F5 \
    ; do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
      done \
    && wget -P /tmp "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
    && tar -xJf "/tmp/node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && wget -P /tmp "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" \
    && mv /tmp/yarn-legacy-$YARN_VERSION.js /usr/local/bin/yarn \
    && chmod +x /usr/local/bin/yarn \
    && npm install -g appium appium-doctor \
    && npm install wd \
    && mkdir -p /root/.Genymobile/Genymotion \
    && rm -rf /var/lib/apt/lists/*

ADD .config /root/.config
  
CMD startxfce4
