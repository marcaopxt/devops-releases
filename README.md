# devops-releases

## Jenkins

A secret must be created with the keys: 
- GITHUB_SSH_PRIVATE_KEY
- SONARQUBE_TOKEN

Create a Jenkins Token in Manage Jenkins/System/Tokens
Create a webhook in Sonarqube in Administration/Configuration/Webhooks pointing to http://jenkins.jenkins.svc.cluster.local:8080/sonarqube-webhook/

Create a Docker registry secret, check this file: 
create-docker-registry-secret.sh

Go to one of the environments folder and run:

terraform plan

Examine the plan to check what resources will be created in apply

If the things are OK, then you can apply it:

terraform apply

Or if you feel comfortable to dismiss the approval question, 

terraform apply -auto-approve

Finally, check the resources created
