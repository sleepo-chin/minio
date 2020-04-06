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

RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio \
    && chmod +x minio

RUN mv minio /usr/local/bin/minio \ 
   && useradd -r minio-user -s /sbin/nologin \
   && chown minio-user:minio-user /usr/local/bin/minio \
   && mkdir /usr/local/share/minio \
   && chown minio-user:minio-user /usr/local/share/minio

USER minio-user
EXPOSE 9000
ENTRYPOINT [ "/usr/local/bin/minio" ]
VOLUME [ "/data" ]
CMD [ "minio","server","/data" ]

