# devops-releases

## Jenkins

A secret must be created with the keys: 
- GITHUB_SSH_PRIVATE_KEY
- SONARQUBE_TOKEN

Create a Jenkins Token in Manage Jenkins/System/Tokens
Create a webhook in Sonarqube in Administration/Configuration/Webhooks pointing to http://jenkins.jenkins.svc.cluster.local:8080/sonarqube-webhook/

Create a Docker registry secret, check this file: 
create-docker-registry-secret.sh

