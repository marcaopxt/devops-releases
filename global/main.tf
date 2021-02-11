######################################################################################################### 
####
#### DATA CONFIG
####
#########################################################################################################

data "google_client_config" "default" {}

######################################################################################################### 
####
#### STATE CONFIG
####
#########################################################################################################

terraform {
  backend "gcs" {
    bucket  = "mapx-devtools-terraform-state"
    prefix  = "module/global.tfstate"
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
    project = var.project_id
    region  = var.region
}

provider "google-beta" {
    project = var.project_id
    region  = var.region
}

######################################################################################################### 
####
#### STORAGE_CLASSES
####
#########################################################################################################

resource "kubernetes_storage_class" "fast" {
  metadata {
    name = "fast"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Delete"

  parameters = {
    type = "pd-ssd"
  }
}

resource "kubernetes_storage_class" "fast-persistent" {
  metadata {
    name = "fast-persistent"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type = "pd-ssd"
  }
}

resource "kubernetes_storage_class" "fast-persistent-replicated" {
  metadata {
    name = "fast-persistent-replicated"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type             = "pd-ssd"
    replication-type = "regional-pd"
  }
}

resource "kubernetes_storage_class" "standard-persistent" {
  metadata {
    name = "standard-persistent"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type = "pd-standard"
  }
}

resource "kubernetes_storage_class" "standard-persistent-replicated" {
  metadata {
    name = "standard-persistent-replicated"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type             = "pd-standard"
    replication-type = "regional-pd"
  }
}

data "kubernetes_storage_class" "hostpath" {
  metadata {
    name = "hostpath"
  }
  reclaim_policy      = "Retain"
}