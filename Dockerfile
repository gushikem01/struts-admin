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

# Copy custom server.xml and startup script
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY start.sh /usr/local/tomcat/bin/start.sh

# Cloud Run optimizations for faster startup
ENV JAVA_OPTS="-Xmx512m -Xms512m -XX:+UseSerialGC -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Djava.security.egd=file:/dev/./urandom"
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8 -Djava.awt.headless=true -Dorg.apache.catalina.startup.EXIT_ON_INIT_FAILURE=true"

# Set default PORT for local development
ENV PORT=8080
EXPOSE $PORT

# Set ownership and permissions
RUN chown -R tomcat:tomcat /usr/local/tomcat \
    && chmod +x /usr/local/tomcat/bin/*.sh

# Switch to tomcat user
USER tomcat

# Health check - simplified and more reliable
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
    CMD curl -f http://localhost:${PORT:-8080}/ || exit 1

# Use custom startup script
CMD ["/usr/local/tomcat/bin/start.sh"]