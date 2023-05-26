FROM php:8.1-apache
# FROM centos
# MAINTAINER yuuki.miyo <メールアドレス>

# プロキシ設定
# ARG proxy='http://xxxx:8080'
# ARG noproxy='xxx,xxx'
# ENV HTTP_PROXY $proxy
# ENV HTTPS_PROXY $proxy
# ENV NO_PROXY $noproxy
# RUN echo "proxy=$proxy" >> /etc/yum.conf

# タイムゾーン変更
# RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENV TZ=Asia/Tokyo

# yum アップデートとパッケージのインストール
#RUN yum update -y --disableplugin=fastestmirror && \
#    yum install -y epel-release --disableplugin=fastestmirror && \
#    yum install -y --disableplugin=fastestmirror sudo cronie supervisor
    
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libonig-dev \
    vim \
    unzip \
    git \
    # cronとtmpreapert、psコマンドを追加
    cron \
    tmpreaper \
    procps \
    supervisor \
    # キャッシュされている全パッケージを削除
    && apt-get clean \
    # キャッシュされている全パッケージリストを削除
    && rm -rf /var/lib/apt/lists/*
# ユーザの追加処理
# RUN groupadd -g 1000 developer && \
#     useradd  -g      developer -m -s /bin/bash dev-user && \
#     echo 'dev-user    ALL=(ALL)    NOPASSWD:ALL' >> /etc/sudoers.d/dev-user

# PAMの設定 cronをフォアグラウンドで起動するために必要
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/cron

# cronの個別コマンドの設定ファイルを追加
# ADD ./cron.d /etc/cron.d/
# RUN chmod 0644 /etc/cron.d/*

# cron動作テスト
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab

# suvervisorの設定
#RUN sed -i \
#        -e 's/nodaemon=false/nodaemon=true/' \
#        /etc/supervisor/supervisord.conf

ADD ./supervisord.conf /etc/supervisor/supervisord.conf
ADD ./supervisord /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
# CMD ["/bin/bash"]