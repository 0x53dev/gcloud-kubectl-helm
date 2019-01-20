FROM google/cloud-sdk:alpine

WORKDIR /root

RUN apk update && apk add ca-certificates docker openssl py2-pip jq nodejs npm yarn && rm -rf /var/cache/apk/*
RUN gcloud components install kubectl -q --no-user-output-enabled && gcloud components install docker-credential-gcr -q --no-user-output-enabled

# Helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
RUN helm init --client-only

# add docker-compose
RUN pip install --upgrade pip && pip install docker-compose
RUN npm install firebase-tools appcenter-cli @sentry/cli -g --unsafe-perm

## For SSH
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh

CMD ["/bin/bash"]
