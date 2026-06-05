FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY target/hello-devops-0.0.1-SNAPSHOT.jar /app/hello-devops.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/hello-devops.jar"]
