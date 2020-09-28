FROM ubuntu:18.04
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install git -y
RUN apt-get install default-jdk -y
RUN apt-get install maven -y

RUN mkdir /usr/local/tomcat
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.16/* /usr/local/tomcat/

#RUN apt-get install tomcat9 -y

WORKDIR /app/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
WORKDIR /app/boxfuse-sample-java-war-hello
RUN mvn package -am -Dmaven.test.skip -T 1C
RUN cp /app/boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]