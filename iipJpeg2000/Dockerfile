#
# Copyright (c) 2009-2017. Authors: see NOTICE file.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:12.04

RUN apt-get -y update && apt-get install -y \
      build-essential \
      cron \
      git \
      libfcgi0ldbl \
      libjpeg8-dev \
      libmemcached-dev \
      libopenjpeg-dev \
      libopenslide-dev \
      libstdc++6 \
      libtiff4 \
      memcached \
      psmisc \
      software-properties-common \
      unzip \
      vim \
      wget \
      zlib1g && \
    apt-get -y build-dep nginx openslide && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget http://nginx.org/download/nginx-1.4.4.tar.gz && \
    tar -zxvf ./nginx-1.4.4.tar.gz && \
    cd /tmp/nginx-1.4.4 && \
    ./configure && \
    make && \
    make install

# Installation of the last version of IIPImage Server, with KAKADU, for JPG2000 images.
RUN cd /tmp && \
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/oldmapsonline/iipimage-server_0.9.9-j2k-0ubuntu12.04_amd64.deb && \
    dpkg -i iipimage-server_0.9.9-j2k-0ubuntu12.04_amd64.deb

RUN mkdir -p /usr/local/httpd/fcgi-bin && \
    cp /usr/lib/cgi-bin/iipsrv.fcgi /usr/local/httpd/fcgi-bin/iipsrv.fcgi

RUN mkdir -p /opt/cytomine/bin
COPY start-iip.sh /opt/cytomine/bin/start-iip.sh
COPY stop-iip.sh /opt/cytomine/bin/stop-iip.sh
COPY check-iip-status.py /opt/cytomine/bin/check-iip-status.py
COPY crontab /tmp/crontab
COPY iipservice /etc/init.d/iip
COPY deploy.sh /tmp/deploy.sh

RUN chmod 755 /etc/init.d/iip
RUN chmod +x /opt/cytomine/bin/stop-iip.sh
RUN chmod +x /opt/cytomine/bin/start-iip.sh
RUN chmod +x /tmp/deploy.sh

RUN ldconfig -v

ENTRYPOINT ["/tmp/deploy.sh"]



