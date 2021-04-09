FROM ubuntu:latest
MAINTAINER Lorenzo Leonardini

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y lsb-release git apt-utils wget cmake pkg-config sqlite3 \
	 libsqlite3-dev bzip2 libbz2-dev libcurl4-nss-dev libjpeg-dev re2c libxml2-dev \
     libtidy-dev libxslt-dev libmcrypt-dev libreadline-dev libfreetype6-dev \
     libonig-dev zlib1g-dev libzip-dev mysql-client g++ autoconf curl
RUN apt-get clean all

COPY PHP_VERSION .
COPY install-php.sh .

# load version
RUN chmod +x install-php.sh
RUN ./install-php.sh $(cat PHP_VERSION)

# install composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php; \
	HASH=`curl -sS https://composer.github.io/installer.sig`; \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { exit(0); } else { exit(1); }" \
	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# RUN cat /etc/passwd
# RUN userdel nobody
RUN useradd -ms /bin/bash user
USER user
RUN mkdir -p /home/user/app
WORKDIR /home/user/app
