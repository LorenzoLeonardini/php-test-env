FROM php:[[version]]
MAINTAINER Lorenzo Leonardini

RUN apk add bash autoconf g++ make git

# install composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php; \
	HASH=`curl -sS https://composer.github.io/installer.sig`; \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { exit(0); } else { exit(1); }" \
	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer && rm composer-setup.php

RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN pear config-set php_ini /usr/local/etc/php/php.ini
RUN pecl install xdebug

ENV XDEBUG_MODE=coverage

RUN mkdir -p /var/app
WORKDIR /var/app
