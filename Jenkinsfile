pipeline {
    environment {
        registryCredential = "docker"
        TF_IN_AUTOMATION      = '1'
//        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
//        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }    
    agent {
      label "jenkins-terraform"
    }
//    options { 
//        timestamps()
//        ansiColor("xterm")
//    }
    tools {
        terraform 'terraform-default'
    }
    parameters {
//        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
//        string(name: 'version', defaultValue: '0.14.5', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    stages {
        stage('Plan') {
            steps {
                container('jenkins-terraform') {
    //                script {
    //                    currentBuild.displayName = params.version
                        sh 'mkdir -p ~/.ssh'
                        sh 'ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts'
                        sh 'terraform init -input=false  -no-color'
    //                    sh 'terraform workspace select ${environment}'
                        sh "terraform plan -input=false  -no-color -out tfplan"
                        // -var 'version=${params.version}' --var-file=environments/${params.environment}.tfvars"
                        sh 'terraform show -no-color'
                        // tfplan > tfplan.txt'
    //                }
                }
            }
        }
/*        
        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }
            steps {
                container('jenkins-terraform') {                
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                }
            }
        }
*/        
        stage('Apply') {
            steps {
                container('jenkins-terraform') {
                    sh "terraform apply --dry-run -input=false"
                }
            }
        }
    }

 //   post {
//        always {
//            archiveArtifacts artifacts: 'tfplan.txt'
//        }
//    }
}