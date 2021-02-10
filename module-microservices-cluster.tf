module "devops-tools" {
    #source = "git@github.com:hashicorp/example.git"
    source = "../terraform-modules/microservices-cluster/devops-tools"
}

# module "routing-tools" {
#     source = "git@github.com:hashicorp/example.git"
#     source = "../terraform-modules/microservices-cluster/routing-tools"
# }

# module "bigdata-tools" {
#     source = "git@github.com:hashicorp/example.git"
#     source = "../terraform-modules/microservices-cluster/bigdata-tools"
# }
