FROM debian:9.4
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN chmod 777 /tmp
RUN apt-get update && apt-get install -y\
    automake\
    cmake\
    equivs\
    make\
    g++\
    gcc\
    gdb\
    gdbserver\
    git\
    gnutls-dev\
    python\
    libgnutls28-dev\
    libmariadbclient-dev\
    libssl-dev\
    libtool\
    libunwind8\
    libunwind-dev\
    vim

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
ENTRYPOINT /opt/entrypoint.sh

