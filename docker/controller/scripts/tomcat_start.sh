#!/usr/bin/env bash
echo "Installed build tools."
java -version
mvn -version
gradle -version

echo "Wait a while extracting war files... It takes time for the first run."
export JAVA_OPTS="-Djava.io.tmpdir=${NGRINDER_HOME}/lib"
${CATALINA_HOME}/bin/startup.sh

tail -f ${CATALINA_HOME}/logs/catalina.out
