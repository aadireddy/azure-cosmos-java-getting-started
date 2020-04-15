FROM tomcat

ARG CONT_IMG_VER
WORKDIR /usr/local/tomcat
EXPOSE 8080
COPY ./target/azure-cosmos-java-getting-started-1.0-SNAPSHOT.jar /usr/local/tomcat/webapps
