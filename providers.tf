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
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
#  client_certificate     = file("~/.kube/apiserver-kubelet-client-crt.pem")
#  client_key             = file("~/.kube/apiserver-kubelet-client-key.pem")
#  cluster_ca_certificate = file("~/.kube/ca.pem") 
  token                  = file("~/.kube/token")
  host = "https://localhost:6443"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Create an Nginx pod
resource "kubernetes_pod" "nginx" {
  metadata {
    name = "terraform-example"
  }

  spec {
    container {
      image = "nginx:1.15.3"
      name  = "example"
    }
  }
}

# Create an service
#resource "kubernetes_service" "nginx" {
#  metadata {
#    name = "terraform-example"
#  }
#  spec {
#    selector {
#      run = "${kubernetes_pod.nginx.metadata.0.labels.run}"
#    }
#    port {
#      port = 80
#    }

#    type = "NodePort"
#  }
#}


