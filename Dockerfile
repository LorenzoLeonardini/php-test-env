FROM ubuntu:latest
MAINTAINER Lorenzo Leonardini

COPY .env .

# load version from .env
RUN PHP_VERSION=$(grep PHP_VERSION .env | xargs)
RUN IFS='=' read -ra PHP_VERSION <<< "$PHP_VERSION"
RUN PHP_VERSION=${PHP_VERSION[1]}

RUN echo "$PHP_VERSION"