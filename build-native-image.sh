#!/bin/bash
mvn clean package -Dnative -DskipTests -Dquarkus.native.container-build=true -Dquarkus.native.container-runtime-options=--platform=linux/arm64 -Dquarkus.native.builder-image=quay.io/quarkus/ubi-quarkus-mandrel-builder-image:23.1.5.0-Final-java21-arm64