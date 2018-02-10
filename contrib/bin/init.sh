#!/bin/bash 

set -e 

mvn --settings /tmp/build-settings.xml install:install-file \
    -Dfile=/tmp/ow-scf-greeter-$APP_VERSION.jar \
    -DgroupId=com.redhat.developers \
    -DartifactId=ow-scf-greeter \
    -Dversion=$APP_VERSION\
    -Dpackaging=jar \
    -DgeneratePom=false \
    -DpomFile=/tmp/pom.xml

# download the dependencies to make the builds run faster and actions boots up faster
mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="com.fasterxml:classmate:1.3.1"

mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="org.apache.httpcomponents:httpclient:4.2.6" 

mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="org.jboss.logging:jboss-logging:3.3.0.Final" 

mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="org.springframework.boot:spring-boot-starter:${SPRING_BOOT_VERSION}"

mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="org.springframework.boot:spring-boot-starter-web:${SPRING_BOOT_VERSION}"

mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="org.springframework.cloud:spring-cloud-function-web:${SPRING_CLOUD_FUNCTION_VERSION}"
mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
 -Dartifact="org.springframework.cloud:spring-cloud-function-compiler:${SPRING_CLOUD_FUNCTION_VERSION}" 

mvn --settings /tmp/build-settings.xml org.apache.maven.plugins:maven-dependency-plugin:3.0.2:get \
-Dartifact="org.springframework:spring-messaging:4.3.13.RELEASE" 
    
java -Dthin.name=function -Dthin.debug=true -Dthin.dryrun=true -jar /tmp/ow-scf-greeter-$APP_VERSION.jar