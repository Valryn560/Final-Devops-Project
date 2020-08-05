FROM maven:latest as build-stage

COPY . .

RUN mvn package
 

FROM openjdk:8-jdk-alpine as prod-stage

WORKDIR /app

COPY --from=build-stage ./target/spring-petclinic-rest-2.2.5.jar .

ENTRYPOINT ["java", "-jar", "spring-petclinic-rest-2.2.5.jar"]


