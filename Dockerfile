FROM google/cloud-sdk:alpine

WORKDIR /root

RUN apk --update add jq yarn
RUN gcloud components install  docker-credential-gcr kubectl

# Helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# Docker credential
RUN gcloud components install docker-credential-gcr

# add docker-compose
RUN pip install docker-compose
RUN npm install firebase-tools -g

## For SSH
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh

CMD ["/bin/bash"]
