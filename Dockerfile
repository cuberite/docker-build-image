FROM ubuntu:bionic

# Install apt tools
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates gpg software-properties-common

# Add cmake repository
ADD https://apt.kitware.com/keys/kitware-archive-latest.asc \
    /root/gpg/kitware-archive-latest.asc
RUN gpg -o /etc/apt/trusted.gpg.d/kitware.gpg \
        --dearmor /root/gpg/kitware-archive-latest.asc && \
    echo "deb https://apt.kitware.com/ubuntu/ bionic main" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y kitware-archive-keyring && \
    rm /etc/apt/trusted.gpg.d/kitware.gpg

# Install build dependencies
RUN apt-get update && \
    apt-get install -y git lua5.1 cmake clang-9 clang-tidy-9 python-yaml

RUN update-alternatives --install /usr/bin/clang      clang      /usr/bin/clang-9      900 && \
    update-alternatives --install /usr/bin/clang++    clang++    /usr/bin/clang++-9    900 && \
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-9 900 && \
    update-alternatives --install /usr/bin/run-clang-tidy run-clang-tidy \
        /usr/bin/run-clang-tidy-9.py 900 && \
    update-alternatives --install /usr/bin/clang-apply-replacements clang-apply-replacements \
        /usr/bin/clang-apply-replacements-9 900
