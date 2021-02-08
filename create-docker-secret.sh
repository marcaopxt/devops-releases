#!/bin/sh

kubectl create secret docker-registry -n jenkins regcred --docker-server=https://hub.docker.com --docker-username=aaaaaaaa --docker-password=xxxxxxxxx --docker-email=aaaaaa@xxxx.sss
