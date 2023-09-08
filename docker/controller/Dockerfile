FROM tomcat:9.0.80-jdk11

RUN apt update && apt install -y curl bash tar unzip

# Install maven
ARG MAVEN_VERSION=3.6.3
RUN mkdir -p /usr/share/maven
COPY files/apache-maven-3.8.8-bin.tar.gz /tmp
RUN tar -xzf /tmp/apache-maven-3.8.8-bin.tar.gz -C /usr/share/maven --strip-components=1
RUN rm -f /tmp/apache-maven-3.8.8-bin.tar.gz

ARG GRADLE_VERSION=6.7.1
ARG GRADLE_DOWNLOAD_BASE_URL=https://services.gradle.org/distributions

# Install gradle
RUN mkdir -p /usr/share/gradle \
  && echo "Downloading gradle" \
  && curl -fsSL -o /tmp/gradle.zip ${GRADLE_DOWNLOAD_BASE_URL}/gradle-${GRADLE_VERSION}-bin.zip \
  && echo "Unziping gradle" \
  && unzip -d /usr/share/gradle /tmp/gradle.zip \
  && rm -f /tmp/gradle.zip

# Set up environment variables
ENV JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8
ENV LANG=en_US.UTF-8
ENV BASE_DIR=/opt \
    NGRINDER_HOME=/opt/ngrinder-controller \
    MAVEN_HOME=/usr/share/maven \
    GRADLE_HOME=/usr/share/gradle/gradle-${GRADLE_VERSION} \
    DOCKER_SCAN_SUGGEST=false

ENV PATH=$PATH:$GRADLE_HOME/bin:$MAVEN_HOME/bin

# Expose ports
EXPOSE 8080 16001 12000-12009

# Volume mapping
VOLUME $NGRINDER_HOME

# Copy initial execution script
COPY scripts /scripts

ARG CATALINA_HOME=/usr/local/tomcat
COPY binary/*.war ${CATALINA_HOME}/webapps
RUN mkdir ${CATALINA_HOME}/webapps/ROOT
RUN unzip -oq ${CATALINA_HOME}/webapps/ngrinder-controller-3.5.8.war -d ${CATALINA_HOME}/webapps/ROOT
RUN rm -rf ${CATALINA_HOME}/webapps/ngrinder-controller-3.5.8.war

# Execution
CMD ["/scripts/tomcat_start.sh"]

