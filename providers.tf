terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.0.1"
    }
    helm = {
      source = "hashicorp/helm" 
      version = "2.0.2"
    }
  }
}

provider "kubernetes" {
  config_path    = "/var/lib/docker/local-volumes/tokens/.kube/config"
#  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
#  client_certificate     = file("~/.kube/apiserver-kubelet-client-crt.pem")
#  client_key             = file("~/.kube/apiserver-kubelet-client-key.pem")
#  cluster_ca_certificate = file("~/.kube/ca.pem") 
  token                  = file("/var/lib/docker/local-volumes/tokens/.kube/token")
#  token                  = file("~/.kube/token")
  host = "https://localhost:6443"
}

provider "helm" {
  kubernetes {
    config_path = "/var/lib/docker/local-volumes/tokens/.kube/config"
    #config_path = "~/.kube/config"
  }
}
