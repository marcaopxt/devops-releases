######################################################################################################### 
####
#### MODULES CONFIG
####
#########################################################################################################

module "global" {
    source = "../global"
    project_id   = "mapx-devtols"
    region       = "us-east1"
}

module "datastore" {
    source = "git::git@github.com:marcaopxt/terraform-modules.git//datastore?ref=v0.5.0"
    #source = "../../terraform-modules/datastore"

    redis_enabled        = true
    redis_release_config = { 
        redis_host = "postgresql.postgresql.svc.cluster.local"
        redisPassword       = "password"      
    }

    postgresql_enabled        = true
    postgresql_release_config = { 
        postgres_username       = "postgres"
        postgres_password       = "password"      
    }
    pgadmin_enabled        = true
    pgadmin_release_config = {
        postgres_host = "postgresql.postgresql.svc.cluster.local"
    }

    cassandra_enabled        = false
    cassandra_release_config = {
        cassandra_enabled = false
        serviceType   = "LoadBalancer"
    }

    mongodb_enabled        = false
    mongodb_release_config = { 
        mongodb_host = "mongodb.mongodb.svc.cluster.local"      
        rootPassword = "password"
    }
}

module "devops" {
    source = "git::git@github.com:marcaopxt/terraform-modules.git//devops?ref=v0.5.2"
    #source = "../../terraform-modules/devops"

    jenkins_release_config = {
            serviceType             = "LoadBalancer"
            prometheusEnabled       = "false"
            mavenAgentTag           = "0.0.1"
            helmAgentTag            = "0.0.1"
            terraformAgentTag       = "0.0.1"
            dockerAgentTag          = "0.0.2"
            chart_admin_username    = "admin"
            chart_admin_password    = "password"
            computer_jnlpmac        = "jenkins-agent"
            computer_name           = "jenkins-agent"
            agent_idle_minutes      = "15" 
    }
}

module "bigdata" {
    source = "git::git@github.com:marcaopxt/terraform-modules.git//bigdata?ref=v0.5.1"
    #source = "../../terraform-modules/bigdata"

    kafka_enabled        = true
    kafka_release_config = {
      
    }

    kafdrop_enabled        = true
    kafdrop_release_config = {
        tagVersion  = "3.27.0"
        kafkaServer = "kafka.kafka.svc.cluster.local:9092"
    }

    spark_enabled        = true
    spark_release_config = {
      
    }

}

######################################################################################################### 
####
#### STATE CONFIG
####
#########################################################################################################
terraform {
  backend "gcs" {
    bucket  = "mapx-devtools-terraform-state"
    prefix  = "state/mgmt.tfstate"
  }  
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    #kubernetes = {
    #  version = "~> 2.0.1"
    #}    
    helm = {
      source = "hashicorp/helm" 
      version = "2.0.2"
    }
    google = {
      version = "~> 3.54"
    }
    google-beta = {
      version = "~> 3.56"
    }
  }
}


######################################################################################################### 
####
#### PROVIDERS
####
#########################################################################################################

provider "kubernetes" {
#  config_path    = "/var/lib/docker/local-volumes/tokens/.kube/config"
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
#  client_certificate     = file("~/.kube/apiserver-kubelet-client-crt.pem")
#  client_key             = file("~/.kube/apiserver-kubelet-client-key.pem")
#  cluster_ca_certificate = file("~/.kube/ca.pem") 
#  token                  = file("/var/lib/docker/local-volumes/tokens/.kube/token")
  token                  = file("~/.kube/token")
  host = "https://localhost:6443"
}
provider "helm" {
  kubernetes {
    #config_path = "/var/lib/docker/local-volumes/tokens/.kube/config"
    config_path = "~/.kube/config"
    #    cluster_ca_certificate = base64decode(local.gke_ca_certificate)
    token =  file("~/.kube/token")
    #    token                  = data.google_client_config.default.access_token    
  }

#  kubernetes {
#    host                   = "https://${local.gke_endpoint}"
#    cluster_ca_certificate = base64decode(local.gke_ca_certificate)
#    token                  = data.google_client_config.default.access_token
    
#    load_config_file       = false
#  }

}
provider "google" {
    project = "mapx-devtools"
    region  = "us-east1"
}
provider "google-beta" {
    project = "mapx-devtools"
    region  = "us-east1"
}

