FROM quay.io/centos/centos:10
LABEL authors="Miro Stauder <miro@sysown.com>"

ARG VERS

RUN [ -z "$VERS" ] && echo -n "\nERROR: Specify version to build. e.g:\ndocker build --build-arg VERS=2.5.1 .\n\n" >&2 && exit 1 || true

RUN cat /etc/redhat-release >&2

# fix keys
#RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

# fix repos
#RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-*.repo
#RUN sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-*.repo
#RUN sed -i 's/mirror./vault./' /etc/yum.repos.d/CentOS-*.repo

RUN yum -y install mysql8.4

RUN echo -e "[proxysql_repo]\nname= ProxySQL YUM repository\nbaseurl=https://repo.proxysql.com/ProxySQL/proxysql-${VERS%.*}.x/centos/\$releasever\ngpgcheck=1\ngpgkey=https://repo.proxysql.com/ProxySQL/proxysql-${VERS%.*}.x/repo_pub_key" > /etc/yum.repos.d/proxysql.repo && \
	yum -y install proxysql-${VERS} && \
	rm -fr /var/lib/proxysql && \
	mkdir -p /var/lib/proxysql

# cleanup rpm cache
RUN yum clean all && \
	rm -rf /var/cache/yum


CMD ["proxysql", "-f", "--idle-threads", "-D", "/var/lib/proxysql"]
