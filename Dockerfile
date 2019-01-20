FROM google/cloud-sdk:alpine

WORKDIR /root

RUN apk update && apk add ca-certificates openssl jq yarn && rm -rf /var/cache/apk/*
RUN gcloud components install kubectl -q --no-user-output-enabled
RUN gcloud components install docker-credential-gcr -q --no-user-output-enabled

# Helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
RUN helm init --client-only

# add docker-compose
RUN pip install docker-compose
RUN npm install firebase-tools -g

## For SSH
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh

CMD ["/bin/bash"]
