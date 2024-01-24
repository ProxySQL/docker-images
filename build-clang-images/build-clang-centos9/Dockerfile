FROM quay.io/centos/centos:stream9
MAINTAINER Miro Stauder <miro@sysown.com>

# install from epel
RUN dnf install epel-release -y && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

# clang & build tools
RUN dnf install -y \
	make cmake automake \
	git patch which \
	bzip2 tar wget

# try avoiding pulling gcc as dependency
RUN dnf install -y --setopt=install_weak_deps=False --best \
	clang lld compiler-rt \
	rpm-build \
	python3 \
	libtool

#RUN clang --version
#RUN gcc --version

# proxysql build dependencies
RUN yum install -y \
	openssl openssl-devel \
	gnutls gnutls-devel \
	libunwind libunwind-devel \
	perl-IPC-Cmd \
	perl-FindBin \
	libuuid-devel \
	zlib-devel

# configure git safe dir
RUN git config --global --add safe.directory '*'

ENV CC=clang
ENV CXX=clang++

RUN ${CXX} --version

# build && install current cmake
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.22/cmake-3.22.1.tar.gz && tar -zxf cmake-3.22.1.tar.gz && cd cmake-3.22.1 && ./configure && gmake -j$(nproc) && gmake install && cd .. && rm -rf cmake-3.22.1.tar.gz cmake-3.22.1

# remove gcc pulled in as clang dependency
#RUN rpm -e --nodeps gcc gcc-c++
