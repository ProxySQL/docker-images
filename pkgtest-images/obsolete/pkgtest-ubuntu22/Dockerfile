FROM ubuntu:22.04
LABEL authors="Miro Stauder <miro@sysown.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "Ubuntu $(cat /etc/os-release | grep 'VERSION=' | sed 's/VERSION=//; s/"//g')" >&2

RUN apt-get update && apt-get -y dist-upgrade

# proxysql dependencies
RUN apt-get -y install\
	libgnutls30\
	ca-certificates

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*
