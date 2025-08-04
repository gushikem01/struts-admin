# Multi-stage build for Struts2 application
FROM openjdk:11-jdk-slim as build

# Install Maven
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Maven files first for better layer caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Production stage
FROM tomcat:9-jdk11-openjdk-slim

# Remove default webapps and manager
RUN rm -rf /usr/local/tomcat/webapps/*

# Install curl for health checks and create tomcat user
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
    && groupadd -r tomcat && useradd -r -g tomcat tomcat

# Copy the built WAR file
COPY --from=build /app/target/struts-admin.war /usr/local/tomcat/webapps/ROOT.war

# Create custom server.xml that uses PORT environment variable
RUN cat > /usr/local/tomcat/conf/server.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Server port="-1" shutdown="SHUTDOWN">
  <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
  <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
  <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
  <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

  <Service name="Catalina">
    <Connector port="${PORT:-8080}" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443"
               maxThreads="200"
               minSpareThreads="10" />

    <Engine name="Catalina" defaultHost="localhost">
      <Host name="localhost" appBase="webapps" unpackWARs="true" autoDeploy="true">
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log" suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b" />
      </Host>
    </Engine>
  </Service>
</Server>
EOF

# Cloud Run optimizations for faster startup
ENV JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true"

# Set default PORT for local development
ENV PORT=8080
EXPOSE $PORT

# Set ownership and permissions
RUN chown -R tomcat:tomcat /usr/local/tomcat
RUN chmod +x /usr/local/tomcat/bin/*.sh

# Create startup script that handles PORT variable properly
RUN cat > /usr/local/tomcat/bin/start.sh << 'EOF'
#!/bin/bash
set -e

# Ensure PORT environment variable is set
export PORT=${PORT:-8080}

echo "Starting Tomcat on port $PORT"
echo "Java version: $(java -version 2>&1 | head -n 1)"
echo "Memory: $(free -h | grep Mem)"

# Start Tomcat
exec catalina.sh run
EOF

RUN chmod +x /usr/local/tomcat/bin/start.sh

# Switch to tomcat user
USER tomcat

# Health check - simplified and more reliable
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
    CMD curl -f http://localhost:${PORT:-8080}/ || exit 1

# Use custom startup script
CMD ["/usr/local/tomcat/bin/start.sh"]