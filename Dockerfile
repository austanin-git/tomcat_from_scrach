FROM ubuntu:18.04
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install git -y
RUN apt-get install default-jdk -y
RUN apt-get install maven -y
RUN apt-get install tomcat9 -y

WORKDIR /app/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
WORKDIR /app/boxfuse-sample-java-war-hello
RUN mvn package -am -Dmaven.test.skip -T 1C
RUN cp /app/boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war

EXPOSE 8080
CMD ["service", "tomcat9", "start"]