#!/bin/bash

# Build the app
mvn clean package -Dquarkus.package.jar.type=mutable-jar -Dquarkus.live-reload.password=foo

# Copy the app to the target rpi; you can use rsync or sftp as well
scp -r target/quarkus-app $RPI_HOST:/$RPI_PROJECT_PATH

# Start the app on the target host; CTRL+C stops the app
ssh -t $RPI_HOST "export QUARKUS_LAUNCH_DEVMODE=true; cd $RPI_PROJECT_PATH; java -jar quarkus-app/quarkus-run.jar"