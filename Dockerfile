FROM openjdk:8-jdk-alpine

ARG appver 

EXPOSE 8080

RUN mkdir /opt/app

COPY build/libs/bootcamp-java-mysql-project-$appver.jar /opt/app

WORKDIR /opt/app

CMD ["java", "-jar", "bootcamp-java-mysql-project-$BUILD_VERSION"]
