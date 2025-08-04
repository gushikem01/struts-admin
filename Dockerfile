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

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Install curl for health checks (Cloud Run requirement)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy the built WAR file
COPY --from=build /app/target/struts-admin.war /usr/local/tomcat/webapps/ROOT.war

# Create logs directory
RUN mkdir -p /usr/local/tomcat/logs

# Cloud Run optimizations
ENV JAVA_OPTS="-Xmx512m -Xms128m -XX:+UseG1GC -XX:MaxGCPauseMillis=200"
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/./urandom"

# Cloud Run uses PORT environment variable
ENV PORT=8080
EXPOSE $PORT

# Configure Tomcat to use PORT environment variable
RUN sed -i 's/8080/${PORT}/g' /usr/local/tomcat/conf/server.xml

# Health check endpoint for Cloud Run
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:${PORT}/ || exit 1

# Use non-root user for security
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat
RUN chown -R tomcat:tomcat /usr/local/tomcat
USER tomcat

# Start Tomcat
CMD ["catalina.sh", "run"]