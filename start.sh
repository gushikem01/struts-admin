#!/bin/bash
set -e

# Cloud Run passes the PORT environment variable
export PORT=${PORT:-8080}

echo "Starting Tomcat on port $PORT"
echo "Java version: $(java -version 2>&1 | head -n 1)"
echo "Memory: $(free -h | grep Mem)"

# If PORT is not 8080, update server.xml dynamically
if [ "$PORT" != "8080" ]; then
    echo "Updating Tomcat connector port to $PORT"
    sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml
fi

# Optimize for Cloud Run startup
export JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"
export JAVA_OPTS="$JAVA_OPTS -XX:+TieredCompilation -XX:TieredStopAtLevel=1"

echo "Starting Catalina..."
exec catalina.sh run