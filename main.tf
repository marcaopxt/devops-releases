resource "helm_release" "jenkins" {
  name          = "jenkins"
  namespace     = "jenkins" 
  chart         = "jenkins-mapx"
  repository    = "https://raw.githubusercontent.com/marcaopxt/helm-charts/master/pkg/jenkins/"
  version       = "3.1.8-rev1"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [templatefile("templates/jenkins-values.tpl.yaml", {
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
#    persistent_volume_claim = kubernetes_persistent_volume_claim.jenkins
    jenkins_token           = "0773eca8fca33e3c71f3a0d8a35eb762f3c17b8d" 
  })]

#  depends_on             = [kubernetes_persistent_volume_claim.jenkins]

}

resource "helm_release" "sonarqube" {
  name             = "sonarqube"
  namespace        = "sonarqube"
  chart            = "sonarqube"
  repository       = "https://oteemo.github.io/charts"
  version          = "9.2.4"                                                                                                                         
  reuse_values     = false
  recreate_pods    = false
  force_update     = false
  create_namespace = true
  values        = [templatefile("templates/sonarqube-values.tpl.yaml", {


  })]
}

resource "helm_release" "spark" {
  name             = "spark"
  namespace        = "spark"
  chart            = "spark"
  repository       = "https://charts.bitnami.com/bitnami"
  version          = "5.1.1"                                                                                                                         
  reuse_values     = false
  recreate_pods    = false
  force_update     = false
  create_namespace = true
  values        = [templatefile("templates/spark-values.tpl.yaml", {


  })]
}

resource "helm_release" "kafka" {
  name             = "kafka"
  namespace        = "kafka"
  chart            = "kafka"
  repository       = "https://charts.bitnami.com/bitnami"
  version          = "12.7.4"                                                                                                                         
  reuse_values     = false
  recreate_pods    = false
  force_update     = false
  create_namespace = true
  values        = [templatefile("templates/kafka-values.tpl.yaml", {


  })]
}

resource "helm_release" "kong" {
  name             = "kong"
  namespace        = "kong"
  chart            = "kong"
  repository       = "https://charts.konghq.com"
  version          = "1.14.3"                                                                                                                         
  reuse_values     = false
  recreate_pods    = false
  force_update     = false
  create_namespace = true
  values        = [templatefile("templates/kong-values.tpl.yaml", {
    install_crds = "false"
  })]
}

module "konga-prod" {
  source  = "bennu/konga/helm"

  db_host   = "postgresql.postgresql.svc.cluster.local"
  db_name   = "konga"
  db_pass   = "password"
  db_user   = "konga"
  namespace = "kong"

  user_data = {
    "username"  = "admin",
  }

  # It is possible to set a definition about the resources pods, so you only need to declare it.
  # using "resources" variable to map the limits as you need.
  resources = {
    requests = {
      memory = "150Mi"
      cpu    = "175m"
    }
    limits = {
      memory = "500Mi"
      cpu    = "650m"
    }
  }
}

# Create an Nginx pod
#resource "kubernetes_pod" "nginx" {
#  metadata {
#    name = "terraform-example"
#  }

#  spec {
#    container {
#      image = "nginx:1.15.3"
#      name  = "example"
#    }
#  }
#}


                                                                                                                                                                             
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



/*
resource "helm_release" "istio" {
  name          = "jenkins"
  namespace     = "istio-system" 
  chart         = "jenkins"
  repository    = "https://charts.jenkins.io"
  version       = "3.1.5"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [templatefile("templates/jenkins-values.tpl.yaml", {
    serviceType          = "LoadBalancer"
    prometheusEnabled    = "false"
    mavenAgentTag        = "jdk11"
    chart-admin-username = "admin"
    chart-admin-password = "password"
    computer_jnlpmac     = "jenkins-agent"
  })]

}
*/
