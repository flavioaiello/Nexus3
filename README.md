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

