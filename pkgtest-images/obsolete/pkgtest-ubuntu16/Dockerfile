FROM ubuntu:16.04
LABEL authors="Miro Stauder <miro@sysown.com>"

RUN echo "Ubuntu $(cat /etc/os-release | grep 'VERSION=' | sed 's/VERSION=//; s/"//g')" >&2

RUN apt-get update && apt-get -y dist-upgrade

# proxysql dependencies
RUN apt-get -y install\
	libgnutls30\
	ca-certificates
