
# Copyright (c) 2009-2019. Authors: see NOTICE file.
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

FROM postgres:11

ENV POSTGIS_MAJOR 2.5
ENV POSTGIS_VERSION 2.5.2+dfsg-1~exp1.pgdg90+1

RUN apt-get update \
    && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        postgresql-server-dev-$PG_MAJOR \
        postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
        postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
        postgis=$POSTGIS_VERSION \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh

EXPOSE 5432
