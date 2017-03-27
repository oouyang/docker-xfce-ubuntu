from ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget \
    && echo deb http://download.virtualbox.org/virtualbox/debian xenial contrib >> /etc/apt/sources.list.d/virtualbox.list \
    && wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - \
    && apt-get update \
    && apt-get install -y --force-yes xfce4 dkms virtualbox-5.1
  
CMD startxfce4
