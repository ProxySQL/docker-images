FROM almalinux:10
LABEL authors="Miro Stauder <miro@sysown.com>"

# update packages
RUN yum update -y

# install from epel
RUN yum install -y epel-release && \
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-10

# gcc & build tools
RUN yum install -y \
	make cmake automake \
	git patch \
	bzip2 tar wget \
	gcc gcc-c++ \
	libtool \
	rpm-build \
	python3 \
	pkg-config

# proxysql build dependencies
RUN yum install -y \
	openssl openssl-devel \
	gnutls gnutls-devel \
	libunwind libunwind-devel \
	perl-IPC-Cmd \
	perl-FindBin \
	libuuid-devel \
	zlib-devel \
	libicu-devel \
	libevent-devel


# debug images need valgrind
RUN yum install -y \
	valgrind valgrind-devel

# cleanup rpm cache
RUN yum clean all && \
	rm -rf /var/cache/yum

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=gcc
ENV CXX=g++

RUN ${CXX} --version
