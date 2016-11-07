FROM ubuntu
MAINTAINER hpatel@channelit.biz
ENV\
	ES_VER=5.0.0
RUN\ 
	apt-get update &&\
	apt-get install -y wget vim nodejs tar npm default-jdk &&\
	apt-get update &&\
	wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VER.tar.gz &&\
	tar xzvf elasticsearch-$ES_VER.tar.gz &&\
	rm elasticsearch-$ES_VER.tar.gz &&\
	ln -s elasticsearch-$ES_VER es &&\
	touch start.sh &&\
	chmod 755 start.sh &&\
	echo "#!/bin/sh" >> start.sh &&\
	echo "./es/bin/elasticsearch -Des.insecure.allow.root=true -d" >> start.sh &&\
	mkdir e-data &&\
	mkdir n-data
EXPOSE 9200 9300