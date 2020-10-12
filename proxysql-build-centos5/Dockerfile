FROM centos:centos5
MAINTAINER Rene Cannao <rene.cannao@gmail.com>

RUN yum install -y automake bzip2 make git openssl openssl-devel patch tar wget gnutls
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum -y install devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ openssl-devel patch
RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/gcc /usr/bin/cc
RUN ln -s /opt/rh/devtoolset-2/root/usr/bin/g++ /usr/bin/g++
RUN echo "export CC=/opt/rh/devtoolset-2/root/usr/bin/gcc" >> /root/.bashrc
RUN echo "export CPP=/opt/rh/devtoolset-2/root/usr/bin/cpp" >> /root/.bashrc
RUN echo "export CXX=/opt/rh/devtoolset-2/root/usr/bin/c++" >> /root/.bashrc
RUN yum install -y rpm-build
RUN cd /usr/local/src && \
  wget --no-check-certificate http://www.cmake.org/files/v2.8/cmake-2.8.10.2.tar.gz && \
  tar -xzvf cmake-2.8.10.2.tar.gz && \
  cd cmake-2.8.10.2 && \
  ./bootstrap && make && make install
RUN cd /root && wget https://cmake.org/files/v3.17/cmake-3.17.0.tar.gz && tar -zxf cmake-3.17.0.tar.gz && cd cmake-3.17.0 && ./configure && gmake && gmake install && cd .. && rm -rf cmake-3.17.0.tar.gz cmake-3.9.2

