from ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget bzip2 linux-headers-4.4.0-22-generic dkms xfce4 \
                                         vnc4server openssl libgstreamer-plugins-base0.10-dev \
                                         libxcomposite-dev libxslt1.1 default-jdk openssh-client \
                                         maven git \
    && echo deb http://download.virtualbox.org/virtualbox/debian xenial contrib >> /etc/apt/sources.list.d/virtualbox.list \
    && wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - \
    && wget -P /tmp https://dl.genymotion.com/releases/genymotion-2.8.1/genymotion-2.8.1_x64.bin \
    && chmod +x /tmp/genymotion-2.8.1_x64.bin \
    && apt-get update \
    && apt-get install -y virtualbox-5.1 \
    && echo 'Y' | /tmp/genymotion-2.8.1_x64.bin \
    && ln -s /opt/genymotion/genymotion/genymotion /usr/bin/genymotion \
    && ln -s /opt/genymotion/genymotion/genymotion-shell /usr/bin/genymotion-shell \
    && ln -s /opt/genymotion/genymotion/gmtool /usr/bin/gmtool \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
  
CMD startxfce4
