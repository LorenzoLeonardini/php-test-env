FROM ubuntu:latest
MAINTAINER Lorenzo Leonardini

COPY PHP_VERSION .
COPY install-php.sh .

# load version
RUN chmod +x install-php.sh
RUN ./install-php.sh $(cat PHP_VERSION)