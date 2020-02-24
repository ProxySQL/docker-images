FROM debian:10
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
    libgnutls28-dev\
    libunwind8\
    libunwind-dev\
    python\
    libmariadbclient-dev\
    libssl-dev\
    libtool\
    vim

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
ENTRYPOINT /opt/entrypoint.sh

