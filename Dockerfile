FROM tomcat

ARG CONT_IMG_VER
WORKDIR /usr/local/tomcat
EXPOSE 8080
COPY ./.jar /usr/local/tomcat/webapps
