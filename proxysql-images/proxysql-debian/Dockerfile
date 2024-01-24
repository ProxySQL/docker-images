FROM debian:12

MAINTAINER Miro Stauder <miro@proxysql.com>

ARG VERS

RUN [ -z "$VERS" ] && echo -n "\nERROR: Specify version to build. e.g:\ndocker build --build-arg VERS=2.5.1 .\n\n" >&2 && exit 1 || true

RUN cat /etc/os-release

RUN apt-get update && \
	apt-get install -y apt-utils

RUN apt-get install -y \
	default-mysql-client \
	wget \
	lsb-release \
	gnupg \
	apt-transport-https \
	ca-certificates

RUN wget -nv -O - "https://repo.proxysql.com/ProxySQL/proxysql-${VERS%.*}.x/repo_pub_key" | \
	gpg --dearmor > /etc/apt/trusted.gpg.d/proxysql-${VERS%.*}.x-keyring.gpg

RUN echo "deb https://repo.proxysql.com/ProxySQL/proxysql-${VERS%.*}.x/$(lsb_release -sc)/ ./" | \
	tee /etc/apt/sources.list.d/proxysql.list && \
	apt-get update && \
	apt-get install proxysql && \
	rm -rf /var/lib/apt/lists/*

CMD ["proxysql", "-f", "--idle-threads", "-D", "/var/lib/proxysql"]
