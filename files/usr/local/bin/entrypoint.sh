#!/bin/sh

echo "*** Fix permissions when mounting external volumes running on technical user ***"
chown -R nexus:nexus ${NEXUS_DATA}

echo "*** Startup $0 suceeded now starting $@ ***"
exec su-exec nexus $(eval echo "$@")
