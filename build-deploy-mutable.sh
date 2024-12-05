#!/bin/bash

# Build the app
# quarkus.live-reload.password=foo must be set in application.properties or passed as system property when the remote side starts
# See https://github.com/quarkusio/quarkus/issues/44933
mvn clean package -Dquarkus.package.jar.type=mutable-jar -Ddev

# Copy the app to the target rpi; you can use rsync or sftp as well
scp -r target/quarkus-app $RPI_HOST:$RPI_PROJECT_PATH

# Start the app on the target host; CTRL+C stops the app
# in remote dev mode, the quarkus.http.host is automatically set to 0.0.0.0
# because we want to listen on all interfaces to make sure the application is accessible
ssh -t $RPI_HOST "export QUARKUS_LAUNCH_DEVMODE=true; cd $RPI_PROJECT_PATH; java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -Dquarkus.live-reload.password=foo -jar quarkus-app/quarkus-run.jar"