FROM debian:12
MAINTAINER Miro Stauder <miro@sysown.com>

RUN echo "Debian $(cat /etc/os-release | grep 'VERSION=' | sed 's/VERSION=//; s/"//g')" >&2

RUN apt-get update && apt-get -y dist-upgrade

# proxysql dependencies
RUN apt-get -y install\
	ca-certificates
