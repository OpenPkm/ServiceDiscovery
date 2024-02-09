
FROM maven:3.6.1-jdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -Dmaven.repo.local=/.m2 -f /home/app/pom.xml --no-transfer-progress -Dmaven.test.skip=true package

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/service.discovery-0.0.1-SNAPSHOT.jar /usr/local/lib/run.jar
ENV SERVER_PORT 0

ENTRYPOINT ["java","-jar", "/usr/local/lib/run.jar"]
