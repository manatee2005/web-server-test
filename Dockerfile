
FROM centos

RUN dnf -y install httpd \
    # cronとtmpreapert、psコマンドを追加
    cron \
    tmpreaper \
    procps
RUN echo "Dockerfile Test on Aapche httpd" > /var/www/html/index.html

EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
ENTRYPOINT ["/usr/sbin/cron"]


# test
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab
