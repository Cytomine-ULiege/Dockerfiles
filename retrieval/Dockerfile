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

ARG FROM_NAMESPACE
ARG FROM_VERSION
FROM ${FROM_NAMESPACE}/java8:$FROM_VERSION


RUN groupadd -r redis && useradd -r -g redis redis

RUN apt-get update \
	&& apt-get install -y curl procps \
	&& rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

ENV REDIS_VERSION 2.8.20
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-2.8.20.tar.gz
ENV REDIS_DOWNLOAD_SHA1 45f134113fb3d75b8c37f7968e46565a70800091

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN buildDeps='gcc libc6-dev make' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/redis \
	&& curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& rm -r /usr/src/redis \
	&& apt-get purge -y --auto-remove $buildDeps


#RUN apt-get -y update && apt-get install -y \
#        procps \
#        redis-server && \
#    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/retrieval/ && \
    cd /tmp/retrieval/ && \
    wget -q https://github.com/loic911/CBIRestAPI/releases/download/v0.5/CBIRest-0.5.zip -O retrieval.zip

RUN touch /tmp/addHosts.sh
COPY testsvectors /tmp/testsvectors
COPY config /tmp/config
COPY redis.conf /tmp/redis.conf
COPY deploy.sh /tmp/deploy.sh
RUN chmod +x /tmp/deploy.sh

ENTRYPOINT ["/tmp/deploy.sh"]
