[![Docker Build Status](https://img.shields.io/docker/build/flavioaiello/nexus3.svg)](https://hub.docker.com/r/flavioaiello/nexus3/)
[![Docker Stars](https://img.shields.io/docker/stars/flavioaiello/nexus3.svg)](https://hub.docker.com/r/flavioaiello/nexus3/)
[![Docker Pulls](https://img.shields.io/docker/pulls/flavioaiello/nexus3.svg)](https://hub.docker.com/r/flavioaiello/nexus3/)

# Nexus3
Minimalistic Sonatype Nexus3 general purpose repository based on alpine linux.

## API
Please refer to the official [API Docs](https://books.sonatype.com/nexus-book/reference3/scripting.html).

## Getting started
Default credentials after startup: `username: admin` and `password: admin123`. 

```
docker build -t nexus3 .
docker run -d -p 8081:8081 -v /tmp/nexus3:/nexus-data --name nexus3 nexus3
``` 

## Versioning
For container image versioning additional labels are provided during build time. The Dockerfile must be extended with an according label argument as shown below:
```
ARG TAG
LABEL TAG=${TAG}
```
Arguments must be passed to the build process using `--build-arg TAG="${TAG}"`.

## Reporting
```
docker inspect --format \
&quot;{{ index .Config.Labels \&quot;com.docker.compose.project\&quot;}},\
 {{ index .Config.Labels \&quot;com.docker.compose.service\&quot;}},\
 {{ index .Config.Labels \&quot;TAG\&quot;}},\
 {{ index .State.Status }},\
 {{ printf \&quot;%.16s\&quot; .Created }},\
 {{ printf \&quot;%.16s\&quot; .State.StartedAt }},\
 {{ index .RestartCount }}&quot; $(docker ps -f name=${STAGE} -q) &gt;&gt; reports/${SHORTNAME}.report
```
