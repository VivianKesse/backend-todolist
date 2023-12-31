FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-20.0.2-jdk -y

FROM openjdk:20.0.2-jdk-slim

COPY . .

RUN apt-get install maven -y
RUN mvn clean install

EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]