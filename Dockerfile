FROM centos:8 
MAINTAINER name tsuneizumisg@iseto.co.jp

EXPOSE 80

RUN dnf install -y nginx 
CMD ["nginx", "-g", "daemon off;"]