from ubuntu:16.04

RUN \
    deb http://download.virtualbox.org/virtualbox/debian xenial contrib \
    && wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - \
    && apt-get update \
    && apt-get install xfce dkms virtualbox-5.1
  
CMD startxfce4
