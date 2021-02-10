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
    token                  = data.google_client_config.default.access_token    
  }
}

provider "google" {
    project     = "mapx-devtools"
    region      = "us-east1"
}

provider "google-beta" {
    project     = "mapx-devtools"
    region      = "us-east1"
}

terraform {
  backend "gcs" {
    bucket  = "mapx-devtools-microservices-tf-state-prod"
    path    = "terraform"
    prefix  = "state"
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

data "google_client_config" "default" {}

data "terraform_remote_state" "microservices-" {
  backend = "gcs"
  config = {
    bucket  = "mapx-devtools-microservices-tf-state-prod"
    prefix  = "data"
  }
}


