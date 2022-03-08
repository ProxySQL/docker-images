FROM centos:centos7
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

# fix keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# fix repos
#RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-*.repo
#RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-*.repo
#RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-*.repo

RUN yum -y update

# proxysql dependencies
RUN yum -y install\
	gnutls\
	groff-base\
	mariadb-libs\
	nettle\
	perl\
	perl-Carp\
	perl-Compress-Raw-Bzip2\
	perl-Compress-Raw-Zlib\
	perl-DBD-MySQL\
	perl-DBI\
	perl-Data-Dumper\
	perl-Encode\
	perl-Exporter\
	perl-File-Path\
	perl-File-Temp\
	perl-Filter\
	perl-Getopt-Long\
	perl-HTTP-Tiny\
	perl-IO-Compress\
	perl-Net-Daemon\
	perl-PathTools\
	perl-PlRPC\
	perl-Pod-Escapes\
	perl-Pod-Perldoc\
	perl-Pod-Simple\
	perl-Pod-Usage\
	perl-Scalar-List-Utils\
	perl-Socket\
	perl-Storable\
	perl-Text-ParseWords\
	perl-Time-HiRes\
	perl-Time-Local\
	perl-constant\
	perl-libs\
	perl-macros\
	perl-parent\
	perl-podlators\
	perl-threads\
	perl-threads-shared\
	trousers
