FROM debian:stretch
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

COPY proxysql_2.0.5-debian9_amd64.deb /proxysql_2.0.5-debian9_amd64.deb
RUN dpkg -i /proxysql_2.0.5-debian9_amd64.deb
RUN rm -rf /proxysql_2.0.5-debian9_amd64.deb

ENTRYPOINT ["proxysql", "-f", "-D", "/var/lib/proxysql"]
