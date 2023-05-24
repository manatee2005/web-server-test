FROM nginx:latest
RUN apt-get install -y tmpreaper
SHELL ["/bin/bash", "-c"]
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab