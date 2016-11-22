#!/bin/sh
docker run -d --name shiny -v $(PWD)/r-data:/srv/shiny-server -v $(PWD):/var/log/shiny-server -p 80:3838 channelit/shiny-loaded