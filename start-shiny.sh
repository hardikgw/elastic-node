#!/bin/sh
docker run -it --name shiny -v /elastic-node/r-data:/srv/shiny-server -v /var/log:/var/log/shiny-server -p 80:3838 channelit/shiny-loaded