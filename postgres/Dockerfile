#
# Copyright (c) 2009-2018. Authors: see NOTICE file.
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
FROM ${FROM_NAMESPACE}/base:$FROM_VERSION

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
#RUN wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
#
## Add PostgreSQL's repository. It contains the most recent stable release
##     of PostgreSQL, ``10.0``.
#RUN echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" >> /etc/apt/sources.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list


# Update the Ubuntu and PostgreSQL repository indexes
ARG POSTGRES_VERSION=9.3
ENV POSTGRES_VERSION ${POSTGRES_VERSION}
RUN apt-get update -y && apt-get install -y \
      make \
      postgresql-${POSTGRES_VERSION} \
      postgresql-client-${POSTGRES_VERSION} \
      postgresql-contrib-${POSTGRES_VERSION} \
      postgresql-server-dev-${POSTGRES_VERSION} \
      postgresql-${POSTGRES_VERSION}-orafce && \
    rm -rf /var/lib/apt/lists/*

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-10`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
    createdb --encoding='utf-8' --template=template0 -O docker docker && \
    psql -d docker -c "CREATE EXTENSION ltree;" && \
    psql -d docker -c "CREATE EXTENSION orafce;" && \
    psql -d postgres -c "UPDATE pg_database SET datistemplate='true' WHERE datname='docker'" && \
    /etc/init.d/postgresql stop

USER root
ARG KMEANS_VERSION=1.1.0
RUN cd /tmp && \
    wget http://api.pgxn.org/dist/kmeans/${KMEANS_VERSION}/kmeans-${KMEANS_VERSION}.zip &&\
    unzip kmeans-${KMEANS_VERSION}.zip && \
    cd /tmp/kmeans-${KMEANS_VERSION} && \
    make && \
    make install && \
    sed -i "s/\$libdir/\/usr\/lib\/postgresql\/${POSTGRES_VERSION}\/lib/g" /tmp/kmeans-${KMEANS_VERSION}/kmeans.sql

USER postgres
RUN /etc/init.d/postgresql start && \
    psql -d docker -f /tmp/kmeans-${KMEANS_VERSION}/kmeans.sql && \
    /etc/init.d/postgresql stop

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/${POSTGRES_VERSION}/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/10/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf
RUN sed -i "/max_connections/c\max_connections = 100                # (change requires restart)" /etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf
RUN sed -i "/shared_buffers/c\shared_buffers = 128MB           # min 128kB" /etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

USER root
