FROM ubuntu:14.04
MAINTAINER Miro Stauder <miro@sysown.com>

RUN chmod 777 /tmp
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8C718D3B5072E1F5 && \
	echo 'deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-apt-config' > /etc/apt/sources.list.d/mysql.list && \
	echo 'deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7' >> /etc/apt/sources.list.d/mysql.list && \
	echo 'deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-tools' >> /etc/apt/sources.list.d/mysql.list && \
	apt-get update && apt-get install -y --force-yes\
	automake\
	cmake3\
	equivs\
	make\
	g++\
	gcc\
	gdb\
	gdbserver\
	git\
	python python3\
	libgnutls28-dev\
	libmysqlclient-dev\
	libssl-dev\
	libtool\
	libboost1.55-all-dev\
	libboost-system1.55-dev\
	libunwind8\
	libunwind8-dev\
	wget\
	uuid-dev

# debug images need valgrind
RUN apt-get update && apt-get install -y \
	valgrind

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version

# build && install current cmake
RUN ln -s /usr/bin/make /usr/bin/gmake
RUN wget -q -O /usr/include/mysql/hash.h https://raw.githubusercontent.com/mysql/mysql-server/5.7/include/hash.h
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1
