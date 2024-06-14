# 운영체제 ubuntu
FROM ubuntu:20.04

# 설치 시 사용자 입력을 요구하는 것을 방지하는 설정
ENV DEBIAN_FRONTEND=noninteractive

# 패키지 설치
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    && apt-get clean

# Tomcat 다운로드 & 설치
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz -O /tmp/tomcat.tar.gz \
    && mkdir /opt/tomcat \
    && tar -xvf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 \
    && rm /tmp/tomcat.tar.gz

# JSP 파일을 Tomcat의 웹 애플리케이션 디렉토리에 복사
COPY webapps/ROOT /opt/tomcat/webapps/ROOT

# Tomcat 포트 설정
EXPOSE 8080

# Tomcat 실행
CMD ["/opt/tomcat/bin/catalina.sh", "run"]