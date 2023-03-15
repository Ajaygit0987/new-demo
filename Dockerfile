FROM tomcat:latest

LABEL maintainer="Kempe Gowda"

ADD ./target/LoginWebApp-1.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
