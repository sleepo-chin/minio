FROM ppc64le/ubuntu:18.04

USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    git \
    locales \
    sudo \
    wget \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "LANGUAGE=en_US.UTF-8" >> /etc/default/locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
RUN echo "LC_TYPE=en_US.UTF-8" >> /etc/default/locale
RUN locale-gen en_US en_US.UTF-8

USER mino-test
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio \
    && chmod +x minio\
    && ./minio server /data