#!/bin/sh
docker run  --name es -d -v $(PWD)/esconfig:/es/config -v $(PWD)/esdata:/es/data -p 9200:9200 -p 9300:9300 channelit/elastic-node