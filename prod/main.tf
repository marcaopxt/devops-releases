module "common" {
    #source = "git::git@github.com:marcaopxt/terraform-modules//microservices-cluster/database-tools?ref=0.0.2"
    source = "../terraform-modules/common"
}

module "database-tools" {
    source = "git::git@github.com:marcaopxt/terraform-modules//microservices-cluster/database-tools?ref=0.0.2"
    #source = "../terraform-modules/microservices-cluster/database-tools"
}

/*
module "routing-tools" {
    #source = "https://raw.githubusercontent.com/marcaopxt/terraform-modules/main/microservices-cluster/routing-tools/routing-tools.tf"
    source = "../terraform-modules/microservices-cluster/routing-tools"
}

module "bigdata-tools" {
    #source = "https://raw.githubusercontent.com/marcaopxt/terraform-modules/main/microservices-cluster/bigdata-tools/bigdata-tools.tf"
    source = "../terraform-modules/microservices-cluster/bigdata-tools"
}
*/

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
