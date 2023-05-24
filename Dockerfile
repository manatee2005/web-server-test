FROM nginx:latest
RUN apt-get update && apt-get install -y tmpreaper && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab