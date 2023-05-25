FROM php:8.1-apache

###################################
# ビルド時にのみ使用する変数定義
# （ビルド後は残りません）
# ※残したい場合はENVを使用し、環境変数とします
###################################
# ARG BUILD_TARGET_SPACE=frontend

###################################
# サーバーローカルのタイムゾーン変更
###################################
ENV TZ=Asia/Tokyo

###################################
# 必要なミドルウェア追加
###################################
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
    # キャッシュされている全パッケージを削除
    && apt-get clean \
    # キャッシュされている全パッケージリストを削除
    && rm -rf /var/lib/apt/lists/*

###################################
# Redis
# + Rewrite機能の有効化（rewrite.load）
# + apache
###################################
# RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
#     && docker-php-ext-install redis pdo_pgsql \
#     && mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled \
#     && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
#     && echo "Listen 8080" >> /etc/apache2/apache2.conf \
#     && echo "Header set X-Frame-Options: sameorigin" >> /etc/apache2/conf-available/security.conf

###################################
# cron
###################################
# 自動起動設定
# RUN update-rc.d cron defaults

# test
RUN echo '* * * * * root echo "Hello World at today" >> /root/greetings.txt' >> /etc/crontab

# CMD ["crond"]
# CMD ["/etc/init.d/cron","status"]
# CMD cron && docker-php-entrypoint php-fpm
# CMD cron && docker-php-entrypoint crond

##################################
# pnp.ini 変更/追加キー情報反映
##################################
# COPY ./prod/php.ini $PHP_INI_DIR/conf.d/

##################################
# httpd.conf差し替え
##################################
# COPY ./prod/httpd.conf /etc/httpd/conf/

##################################
# 非公開資産を/usr/local/に
##################################
# COPY ./private/ /usr/local/
# COPY ./prod/cert/ /usr/local/cert/

##################################
# 公開資産をドキュメントルートに
##################################
# COPY ./public/ /var/www/html/

##################################
# ターミナルアクセス時の初期ディレクトリ設定
##################################
# WORKDIR /usr/local/

##################################
# ヘッダーモジュール有効化
##################################
# RUN a2enmod headers
