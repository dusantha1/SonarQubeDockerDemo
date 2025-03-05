# Step 1: Build Stage
FROM maven:3.9.9-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY . .

# Build the project and run tests
RUN mvn clean package

# Step 2: Runtime Stage
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port (update if needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
