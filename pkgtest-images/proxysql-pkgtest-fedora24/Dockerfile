FROM fedora:24
MAINTAINER Miro Stauder <miro@sysown.com>

RUN cat /etc/redhat-release >&2

RUN dnf makecache && dnf -y update

# proxysql dependencies
RUN dnf -y install\
	groff-base\
	mariadb-common\
	mariadb-config\
	mariadb-libs\
	perl\
	perl-Carp\
	perl-DBD-MySQL\
	perl-DBI\
	perl-Data-Dumper\
	perl-Encode\
	perl-Errno\
	perl-Exporter\
	perl-File-Path\
	perl-File-Temp\
	perl-Getopt-Long\
	perl-HTTP-Tiny\
	perl-IO\
	perl-MIME-Base64\
	perl-Math-BigInt\
	perl-Math-Complex\
	perl-PathTools\
	perl-Pod-Escapes\
	perl-Pod-Perldoc\
	perl-Pod-Simple\
	perl-Pod-Usage\
	perl-Scalar-List-Utils\
	perl-Socket\
	perl-Storable\
	perl-Term-ANSIColor\
	perl-Term-Cap\
	perl-Text-ParseWords\
	perl-Text-Tabs+Wrap\
	perl-Time-Local\
	perl-Unicode-Normalize\
	perl-constant\
	perl-libs\
	perl-macros\
	perl-parent\
	perl-podlators\
	perl-threads\
	perl-threads-shared
