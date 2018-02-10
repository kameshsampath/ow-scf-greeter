FROM kameshsampath/ow-scf-app-runner

USER user

ARG FUNCTION_NAME="greeter"
ARG APP_VERSION
ARG SPRING_BOOT_VERSION
ARG SPRING_CLOUD_FUNCTION_VERSION
ARG JAVA_APP_NAME

ENV FUNCTION_NAME="${FUNCTION_NAME}" \
    THIN_NAME="function" \
    THIN_DEBUG="true" \
    SPRING_BOOT_VERSION="${SPRING_BOOT_VERSION}" \
    SPRING_CLOUD_FUNCTION_VERSION="${SPRING_CLOUD_FUNCTION_VERSION}" \
    JAVA_APP_NAME="${JAVA_APP_NAME}"

ADD ./target/function.properties /deployments/function.properties
ADD ./pom.xml /tmp/pom.xml
ADD ./target/ow-scf-greeter-${APP_VERSION}.jar /tmp/ow-scf-greeter-${APP_VERSION}.jar

ADD ./contrib/bin/init.sh /tmp/init.sh 

# TODO change to build ARG and pass via --build-arg 
# this is just to make builds faster (faster builds if its pointing to local nexus)
ADD ./contrib/build-settings.xml  /tmp/build-settings.xml

# Install the app jar to local maven repo and compute all other stuff
USER root
RUN chmod +x /tmp/init.sh

USER user
RUN /tmp/init.sh

ENV JAVA_OPTIONS=" -Dthin.offline=true"
