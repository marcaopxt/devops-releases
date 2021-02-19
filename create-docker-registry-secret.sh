#!/bin/sh

kubectl create secret docker-registry -n jenkins regcred --docker-server=https://hub.docker.com --docker-username=aaaaaaaa --docker-password=xxxxxxxxx --docker-email=aaaaaa@xxxx.sss

kubectl create secret generic jenkins-keys -n jenkins --from-file=GITHUB_SSH_PRIVATE_KEY=/home/${USER}/.ssh/id_rsa 
