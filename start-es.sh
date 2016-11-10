#!/bin/sh
docker run -it --name es -v $(PWD)/esconfig:/es/config -v $(PWD)/esdata:/es/data -v $(PWD)/eslogs:/es/logs -p 9200:9200 -p 9300:9300 channelit/elastic-node ./start.sh