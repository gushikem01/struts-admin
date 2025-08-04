# Struts2 Admin Dashboard

A modern admin dashboard built with Struts2 framework, following DDD (Domain-Driven Design) and Clean Architecture principles, with Ant Design UI components.

## Features

- **Authentication System**: Login/logout functionality with session management
- **Dashboard**: Real-time statistics and system information
- **Modern UI**: Ant Design components for responsive and beautiful interface
- **Clean Architecture**: Separation of concerns with domain, application, and infrastructure layers
- **DDD Principles**: Domain-driven design with proper entity and service modeling
- **Docker Support**: Containerized deployment ready for cloud platforms

## Architecture

```
src/main/java/com/struts/admin/
├── domain/
│   ├── entity/          # Domain entities (User, DashboardData)
│   ├── repository/      # Repository interfaces
│   └── service/         # Domain services
├── application/
│   ├── dto/            # Data Transfer Objects
│   └── usecase/        # Application use cases
└── infrastructure/
    ├── persistence/    # Repository implementations
    └── web/           # Web layer (Actions, Interceptors)
```

## Tech Stack

- **Backend**: Struts2 2.5.30, Java 11
- **Frontend**: JSP, Ant Design CSS/Components
- **Build Tool**: Maven
- **Server**: Tomcat 9
- **Containerization**: Docker
- **Deployment**: Google Cloud Run (via Docker)

## Demo Users

| Username | Password | Role  |
|----------|----------|-------|
| admin    | admin123 | ADMIN |
| user     | user123  | USER  |
| guest    | guest123 | GUEST |

## Getting Started

### Prerequisites

- Java 11 or higher
- Maven 3.6+
- Docker (optional)

### Local Development

1. **Clone and build the project:**
   ```bash
   cd workspace/struts-admin
   mvn clean compile
   ```

2. **Run with Jetty (recommended for development):**
   ```bash
   mvn jetty:run
   ```
   Application will be available at: http://localhost:8080

3. **Or build and deploy to Tomcat:**
   ```bash
   mvn clean package
   # Deploy target/struts-admin.war to your Tomcat webapps directory
   ```

### Docker Deployment

1. **Build Docker image:**
   ```bash
   docker build -t struts-admin .
   ```

2. **Run container:**
   ```bash
   docker run -p 8080:8080 struts-admin
   ```

### Google Cloud Run Deployment

1. **Prerequisites:**
   - Google Cloud account with billing enabled
   - `gcloud` CLI installed and authenticated
   - Docker installed locally

2. **Quick Deploy:**
   ```bash
   # Replace 'your-project-id' with your actual GCP project ID
   ./deploy.sh your-project-id us-central1
   ```

3. **Manual Deploy:**
   ```bash
   # Set your project
   gcloud config set project YOUR_PROJECT_ID
   
   # Enable required APIs
   gcloud services enable cloudbuild.googleapis.com run.googleapis.com
   
   # Build and deploy
   gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/struts-admin .
   gcloud run deploy struts-admin \
     --image gcr.io/YOUR_PROJECT_ID/struts-admin \
     --region us-central1 \
     --platform managed \
     --allow-unauthenticated
   ```

4. **CI/CD with Cloud Build:**
   ```bash
   # Connect your GitHub repository to Cloud Build
   gcloud builds triggers create github \
     --repo-name=struts-admin \
     --repo-owner=YOUR_GITHUB_USERNAME \
     --branch-pattern="^main$" \
     --build-config=cloudbuild.yaml
   ```

## Project Structure

```
struts-admin/
├── src/
│   ├── main/
│   │   ├── java/com/struts/admin/
│   │   │   ├── domain/
│   │   │   ├── application/
│   │   │   └── infrastructure/
│   │   ├── resources/
│   │   │   ├── struts.xml
│   │   │   └── log4j2.xml
│   │   └── webapp/
│   │       ├── views/
│   │       │   ├── login/
│   │       │   └── dashboard/
│   │       ├── WEB-INF/web.xml
│   │       └── index.jsp
├── Dockerfile
├── cloudbuild.yaml
├── deploy.sh
├── pom.xml
└── README.md
```

## Key Features

### Authentication
- Session-based authentication
- Role-based access control
- Secure interceptors for protected routes

### Dashboard
- Real-time statistics display
- System information monitoring
- Responsive Ant Design layout
- Auto-refresh capabilities (configurable)

### Clean Architecture Benefits
- **Testability**: Easy to unit test business logic
- **Maintainability**: Clear separation of concerns
- **Flexibility**: Easy to swap implementations
- **Scalability**: Modular design supports growth

## Development

### Adding New Features

1. **Domain Layer**: Define entities and business rules
2. **Application Layer**: Create DTOs and use cases
3. **Infrastructure Layer**: Implement repositories and web components
4. **Presentation Layer**: Create JSP views with Ant Design

### Testing

```bash
mvn test
```

### Linting and Code Style

The project uses standard Java conventions with Lombok for reducing boilerplate code.

## Security Considerations

- Input validation on all forms
- Session management with timeout
- SQL injection prevention (using parameterized queries)
- XSS protection in JSP templates
- Authentication interceptors for protected routes

## Performance

- Lazy loading of dashboard data
- Efficient session management
- Optimized Docker image with multi-stage build
- CDN-served Ant Design assets

## Contributing

1. Follow the existing architecture patterns
2. Maintain separation of concerns
3. Add tests for new features
4. Update documentation as needed

## License

This project is for demonstration purposes.

---

**Built with ❤️ using Struts2, Clean Architecture, and Ant Design**