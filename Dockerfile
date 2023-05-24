FROM nginx:latest
SHELL ["/bin/bash", "-c"]
RUN apt-get install tmpreaper
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab