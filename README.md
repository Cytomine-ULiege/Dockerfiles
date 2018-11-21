# Cytomine Dockerfiles

> This repository provides a set of Dockerfile used to build some Cytomine Docker images which are not related to other Cytomine projects. These images are used in the Cytomine-bootstrap procedure.

[![Build Status](https://travis-ci.com/Cytomine-ULiege/Dockerfiles.svg?branch=master)](https://travis-ci.com/Cytomine-ULiege/Dockerfiles)
[![GitHub release](https://img.shields.io/github/release/Cytomine-ULiege/Dockerfiles.svg)](https://github.com/Cytomine-ULiege/Dockerfiles/releases)
[![GitHub](https://img.shields.io/github/license/Cytomine-ULiege/Dockerfiles.svg)](https://github.com/Cytomine-ULiege/Dockerfiles/blob/master/LICENSE)

## Overview

Every Cytomine component is encapsulated inside a Docker container. The recipes to build these containers are Dockerfiles. 

The Dockerfiles of Cytomine components with their own Github repository are directly stored in such repositories. You will find here Dockerfiles for components not associated to a dedicated Github repository.

### Dockerfiles inside this repository
Base Dockerfiles:
* `base` (inherits official `ubuntu`)
* `java8` (inherits `base`)
* `tomcat7` (intherits `java8`)

Database Dockerfiles:
* `backup` (inherits `base`)
* `mongodb` (inherits `base`)
* `postgres` (inherits `base`)
* `postgis` (inherits `postgres`)

Cytomine component Dockerfiles:
* `slurm` (inherits official `centos`)
* `rabbitmq` (inherits `base`)
* `memcached` (inherits `base`)
* `nginx` (inherits `base`)
* `iip-jp2000` (inherits `base`)
* `iip-cyto` (inherits `base`)
* `retrieval` (inherits `java8`)
* `bioformat` (inherits `java8`)
* `iris` (inherits `tomcat7`)

### Dockerfiles outside this repository
Cytomine component Dockerfiles:
* `core` (inherits `tomcat7`) - See [Cytomine-core repository](https://github.com/Cytomine-ULiege/Cytomine-core)
* `ims` (inherits `tomcat7`) - See [Cytomine-IMS repository](https://github.com/Cytomine-ULiege/Cytomine-IMS)
* `software_router` (inherits `java8`) - See [Cytomine-software-router repository](https://github.com/Cytomine-ULiege/Cytomine-software-router)

Base Dockerfiles for Cytomine software:
* `software-python2-base` (inherits official `python`) - See [Cytomine-python-client repository](https://github.com/Cytomine-ULiege/Cytomine-python-client)
* `software-python3-base` (inherits official `python`) - See [Cytomine-python-client repository](https://github.com/Cytomine-ULiege/Cytomine-python-client)
* `software-java8-base` (inherits official `openjdk`) - See [Cytomine-java-client repository](https://github.com/Cytomine-ULiege/Cytomine-java-client)
* `software-groovy-base` (inherits official `groovy`) - See [Cytomine-java-client repository](https://github.com/Cytomine-ULiege/Cytomine-java-client)

## Install
**To install *official* release of Cytomine, see @cytomine. Follow this guide to install forked version by ULiege.** 

It is automatically installed with the [Cytomine-bootstrap](https://github.com/Cytomine-ULiege/Cytomine-bootstrap) procedure using Docker. See [Cytomine installation documentation](http://doc.cytomine.be/pages/viewpage.action?pageId=10715266) for more details.

## Develop

1. Set versions in `versions.sh`
2. Build images with `sh build_images.sh`
3. Push built images onto a Docker registry such as DockerHub with `sh push_images.sh`

## References
When using our software, we kindly ask you to cite our website url and related publications in all your work (publications, studies, oral presentations,...). In particular, we recommend to cite (Marée et al., Bioinformatics 2016) paper, and to use our logo when appropriate. See our license files for additional details.

- URL: http://www.cytomine.org/
- Logo: [Available here](https://cytomine.coop/sites/cytomine.coop/files/inline-images/logo-300-org.png)
- Scientific paper: Raphaël Marée, Loïc Rollus, Benjamin Stévens, Renaud Hoyoux, Gilles Louppe, Rémy Vandaele, Jean-Michel Begon, Philipp Kainz, Pierre Geurts and Louis Wehenkel. Collaborative analysis of multi-gigapixel imaging data using Cytomine, Bioinformatics, DOI: [10.1093/bioinformatics/btw013](http://dx.doi.org/10.1093/bioinformatics/btw013), 2016. 

## License

Apache 2.0