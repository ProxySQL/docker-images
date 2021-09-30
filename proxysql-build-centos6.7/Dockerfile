FROM centos:centos6.7
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

COPY ./CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y yum-plugin-ovl yum-utils
RUN yum install -y automake bzip2 cmake make git openssl openssl-devel patch tar wget gnutls libgnutls gnutls-devel libtool
RUN wget --no-check-certificate http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN sed -i 's/http/https/g' /etc/yum.repos.d/devtools-2.repo
RUN echo "sslverify=0" >> /etc/yum.repos.d/devtools-2.repo

RUN yum -y install devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ cmake openssl-devel patch
RUN ln -fs /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/cc
RUN ln -fs /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++
RUN echo "export CC=/opt/rh/devtoolset-2/root/usr/bin/gcc" >> /root/.bashrc
RUN echo "export CPP=/opt/rh/devtoolset-2/root/usr/bin/cpp" >> /root/.bashrc
RUN echo "export CXX=/opt/rh/devtoolset-2/root/usr/bin/c++" >> /root/.bashrc
RUN yum install -y rpm-build
RUN yum -y install gnutls-devel libtool || true
RUN yum -y install epel-release
RUN sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
RUN yum -y install http://repo.okay.com.mx/centos/6/x86_64/release/okay-release-1-1.noarch.rpm
RUN yum -y upgrade automake autoconf
RUN cd /root && wget --no-check-certificate https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2
