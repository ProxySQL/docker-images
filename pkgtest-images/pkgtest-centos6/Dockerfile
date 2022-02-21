FROM centos:centos6
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y update

# proxysql dependencies
RUN yum -y install\
	gnutls\
	mysql-libs\
	perl-DBD-MySQL\
	perl-DBI


