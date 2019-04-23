#!/usr/bin/env bash

. ./versions.sh

docker build -t $NAMESPACE/base:$BASE_VERSION base/
docker build -t $NAMESPACE/java8:$JAVA8_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION java8/
docker build -t $NAMESPACE/tomcat7:$TOMCAT7_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$JAVA8_VERSION tomcat7/

docker build -t $NAMESPACE/backup:$BACKUP_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION auto_backup/
docker build -t $NAMESPACE/mongodb:$MONGODB_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION mongodb/
docker build -t $NAMESPACE/postgres:$POSTGRES_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION postgres/
docker build -t $NAMESPACE/postgis:$POSTGIS_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$POSTGRES_VERSION postgis/

docker build -t $NAMESPACE/memcached:$MEMCACHED_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION memcached/
docker build -t $NAMESPACE/rabbitmq:$RABBITMQ_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION rabbitmq/
docker build -t $NAMESPACE/nginx:$NGINX_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$BASE_VERSION nginx/

docker build -t $NAMESPACE/iip-jp2000:$IIPJP2_VERSION iipJpeg2000/
docker build -t $NAMESPACE/slurm:$SLURM_VERSION slurm/

# Temporary
docker build -t $NAMESPACE/retrieval:$RETRIEVAL_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$JAVA8_VERSION retrieval/
docker build -t $NAMESPACE/iris:$IRIS_VERSION --build-arg FROM_NAMESPACE=$NAMESPACE --build-arg FROM_VERSION=$TOMCAT7_VERSION iris/
