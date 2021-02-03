resource "helm_release" "jenkins" {
  name          = "jenkins"
  namespace     = "jenkins" 
  chart         = "jenkins"
  repository    = "https://charts.jenkins.io"
  version       = "3.1.5"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [templatefile("templates/jenkins-values.tpl.yaml", {
    serviceType             = "LoadBalancer"
    prometheusEnabled       = "false"
    mavenAgentTag           = "jdk11"
    chart-admin-username    = "admin"
    chart-admin-password    = "password"
    computer_jnlpmac        = "jenkins-agent"
    computer_name           = "jenkins-agent"
    agent_idle_minutes      = "15"
    persistent_volume_claim = kubernetes_persistent_volume_claim.jenkins_workspace
  })]

  depends_on             = [kubernetes_persistent_volume_claim.jenkins_workspace]

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