#!/bin/bash
# -Ddebug=false - disable debugging; debugging is enabled for the remote side
# -Dquarkus.package.jar.type=mutable-jar - build mutable jar
# -Dquarkus.live-reload.password=foo -  
# -Dquarkus.live-reload.url=http://$RPI_HOST:8080 - remote side URL 
# -Ddev - enable "dev" profile
mvn quarkus:remote-dev -Ddebug=false -Dquarkus.package.jar.type=mutable-jar -Dquarkus.live-reload.password=foo -Dquarkus.live-reload.url=http://$RPI_HOST:8080 -Ddev