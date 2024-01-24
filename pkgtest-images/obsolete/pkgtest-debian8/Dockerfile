FROM debian:8
MAINTAINER Miro Stauder <miro@sysown.com>

RUN echo "Debian $(cat /etc/os-release | grep 'VERSION=' | sed 's/VERSION=//; s/"//g')" >&2

RUN sed -i '/jessie-updates/d' /etc/apt/sources.list; \
	sed -i 's/deb.debian/archive.debian/' /etc/apt/sources.list; \
	sed -i 's/security.debian/archive.debian/' /etc/apt/sources.list; \
	sed -i 's/deb /deb [trusted=yes] /' /etc/apt/sources.list

RUN apt-get update && apt-get -y dist-upgrade

# proxysql dependencies
RUN apt-get -y install\
	ca-certificates
