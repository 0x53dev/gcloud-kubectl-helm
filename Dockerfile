FROM alpine:edge

ARG CLOUD_SDK_VERSION=229.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

ARG HELM_VERSION=2.12.0
ENV HELM_VERSION=$HELM_VERSION

ENV HELM_BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV HELM_TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"


ENV PATH /google-cloud-sdk/bin:$PATH
RUN apk upgrade --update 
RUN apk --no-cache add \
        curl \
        python \
        libffi-dev \
        python2-dev \
        openssl-dev \
        py-pip \
        py-crcmod \
        bash \
        make \
        g++ \
        libc6-compat \
        openssl \
        openssh-client \
        git \
        nodejs \
        npm \
        yarn \
        docker \
        mongodb-tools \
        jq \
        gnupg \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud components install kubectl -q --no-user-output-enabled  && \
    gcloud components install docker-credential-gcr -q --no-user-output-enabled  && \
    gcloud --version && \
    curl -L ${HELM_BASE_URL}/${HELM_TAR_FILE} | tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    pip install --upgrade pip && \
    pip install docker-compose && \
    npm install firebase-tools appcenter-cli @sentry/cli semver newman -g --unsafe-perm && \
    curl https://docs.google.com/uc\?id\=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA\&export\=download -o /google-cloud-sdk/bin/gdrive && \
    chmod +x /google-cloud-sdk/bin/gdrive && \
    rm -rf /var/cache/apk/*
    
VOLUME ["/root/.config"]

## For SSH
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh

CMD ["/bin/bash"]
