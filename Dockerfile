FROM ubuntu:14.04.4

MAINTAINER Rob Holmes <email@robholmes.net>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -q -y language-pack-en-base software-properties-common && \
    LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php5-5.6 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -q -y php5-fpm \
                          php5-cli \
                          php5-curl \
                          php5-intl \
                          php5-json \
                          php5-mcrypt

ADD php-fpm.ini /etc/php5/fpm/conf.d/
ADD php-fpm.ini /etc/php5/cli/conf.d/

ADD app.pool.conf /etc/php5/fpm/pool.d/

RUN ln -sf /dev/stdout /var/log/php5-fpm.log

RUN usermod -u 1000 www-data

EXPOSE 9000

CMD ["php5-fpm", "-F"]