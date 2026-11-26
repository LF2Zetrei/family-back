#Step 1 : build jar with maven
FROM maven:3.9-eclipse-temurin-25 AS builder
WORKDIR /app

# Copy the pom alone first so the dependency layer stays cached
# as long as pom.xml doesn't change.
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Then the sources, and build the jar (tests skipped).
COPY src ./src
RUN mvn package -DskipTests -B

#Step 2 : final image, only the JRE + the jar
FROM eclipse-temurin:25-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
