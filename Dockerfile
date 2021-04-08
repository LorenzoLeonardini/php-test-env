FROM ubuntu:latest
MAINTAINER Lorenzo Leonardini

COPY PHP_VERSION .

# load version
RUN PHP_VERSION=$(cat PHP_VERSION)

RUN echo "$PHP_VERSION"