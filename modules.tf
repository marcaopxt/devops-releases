module "devops-tools" {
    source = "git@github.com:marcaopxt/terraform-modules//microservices-cluster/devops-tools?ref=0.0.2"
    #source = "../terraform-modules/microservices-cluster/devops-tools"
}
module "database-tools" {
    source = "git@github.com:marcaopxt/terraform-modules//microservices-cluster/database-tools?ref=0.0.2"
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