# Base image: Maven + Java 17
FROM maven:3.9.6-eclipse-temurin-17

WORKDIR /app

# Copy pom.xml first to leverage Docker caching
COPY pom.xml ./

# Resolve Maven dependencies
RUN mvn dependency:resolve

# Copy the rest of the project
COPY . .

# Default command: run tests
CMD ["mvn", "test"]
