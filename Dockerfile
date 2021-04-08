FROM ubuntu:latest
MAINTAINER Lorenzo Leonardini

COPY PHP_VERSION .

# load version
RUN echo "$(cat PHP_VERSION)"