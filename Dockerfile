FROM ubuntu:bionic
 
# Install build dependencies
RUN apt-get update && \
    apt-get install -y git lua5.1 cmake clang clang-tidy python-yaml
