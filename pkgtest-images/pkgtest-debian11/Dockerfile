FROM debian:11
LABEL authors="Miro Stauder <miro@sysown.com>"

RUN echo "Debian $(cat /etc/os-release | grep 'VERSION=' | sed 's/VERSION=//; s/"//g')" >&2

RUN apt-get update && apt-get -y dist-upgrade

# proxysql dependencies
RUN apt-get -y install\
	ca-certificates

# clean apt cache
RUN apt clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*
