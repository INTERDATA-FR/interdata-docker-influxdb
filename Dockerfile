ARG	UBUNTU_IMAGE
FROM	${UBUNTU_IMAGE}

MAINTAINER Thibault CHEVALLERAUD <tchevalleraud@interdata.fr>

RUN	apt-get -y update && \
	apt-get -y upgrade

RUN	apt-get -y install build-essential wget

ARG	INFLUXDB_IMAGE
RUN	wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_IMAGE}_amd64.deb
RUN	dpkg -i influxdb_${INFLUXDB_IMAGE}_amd64.deb

WORKDIR /

RUN	mkdir /opt/influxdb/

ADD	config/script.init.sh /usr/bin/script.init.sh
ADD	config/config.toml /opt/influxdb/config.toml

RUN	chmod 755 /usr/bin/script.init.sh

EXPOSE	8083
EXPOSE	8086

ENTRYPOINT ["script.init.sh"]
