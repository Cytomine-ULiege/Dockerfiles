#!/usr/bin/env bash

. ./versions.sh

docker push $NAMESPACE/base:$BASE_VERSION
docker push $NAMESPACE/java8:$JAVA8_VERSION
docker push $NAMESPACE/tomcat7:$TOMCAT7_VERSION

docker push $NAMESPACE/backup:$BACKUP_VERSION
docker push $NAMESPACE/mongodb:$MONGODB_VERSION
docker push $NAMESPACE/postgres:$POSTGRES_VERSION
docker push $NAMESPACE/postgis:$POSTGIS_VERSION

docker push $NAMESPACE/memcached:$MEMCACHED_VERSION
docker push $NAMESPACE/rabbitmq:$RABBITMQ_VERSION
docker push $NAMESPACE/nginx:$NGINX_VERSION

docker push $NAMESPACE/iip-jp2000:$IIPJP2_VERSION
docker push $NAMESPACE/slurm:$SLURM_VERSION

# Temporary
docker push $NAMESPACE/retrieval:$RETRIEVAL_VERSION
docker push $NAMESPACE/bioformat:$BIOFORMAT_VERSION
docker push $NAMESPACE/iris:$IRIS_VERSION

