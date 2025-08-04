# Multi-stage build for Struts2 application
FROM openjdk:11-jdk-slim as build

# Install Maven
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Maven files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Production stage
FROM tomcat:9-jdk11-openjdk-slim

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file
COPY --from=build /app/target/struts-admin.war /usr/local/tomcat/webapps/ROOT.war

# Create logs directory
RUN mkdir -p /usr/local/tomcat/logs

# Set environment variables
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8"

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Install curl for health check
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Start Tomcat
CMD ["catalina.sh", "run"]