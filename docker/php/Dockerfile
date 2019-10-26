FROM php:7.1.7-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev

RUN docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt

RUN apt-get update && apt-get install -y  --no-install-recommends \
            libgmp-dev \
            libpq-dev \
            libz-dev \
            libmemcached-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-install zip pdo pdo_pgsql pdo_mysql gmp

RUN apt-get install -y git

RUN pecl install apcu-5.1.8 \
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

RUN pecl install memcached-3.0.3 && echo extension=memcached.so > /usr/local/etc/php/conf.d/memcached.ini

RUN apt-get update && apt-get install -y imagemagick libmagickwand-dev

RUN pecl install imagick && echo extension=imagick.so > /usr/local/etc/php/conf.d/imagick.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer global require hirak/prestissimo
RUN composer global require "laravel/installer"
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
RUn apt-get update && apt-get install -y aapt
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs