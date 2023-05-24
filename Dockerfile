FROM nginx:latest
USER root

SHELL ["/bin/bash", "-c"]
RUN apt-get -y update nginx
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab