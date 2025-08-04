#!/bin/bash
set -e

# Ensure PORT environment variable is set
export PORT=${PORT:-8080}

echo "Starting Tomcat on port $PORT"
echo "Java version: $(java -version 2>&1 | head -n 1)"
echo "Memory: $(free -h | grep Mem)"

# Start Tomcat
exec catalina.sh run