resource "kubernetes_namespace" "jenkins" {
  metadata {
    annotations = {}
    labels = {}
    name = "jenkins"
  }
}
resource "kubernetes_namespace" "keycloak" {
  metadata {
    annotations = {}
    labels = {}
    name = "keycloak"
  }
}
resource "kubernetes_namespace" "istio-system" {
  metadata {
    annotations = {}
    labels = {}
    name = "istio-system"
  }
}
resource "kubernetes_namespace" "transactions" {
  metadata {
    annotations = {}
    labels = {}
    name = "transactions"
  }
}
resource "kubernetes_namespace" "authentication" {
  metadata {
    annotations = {}
    labels = {}
    name = "authentication"
  }
}

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
    serviceType          = "LoadBalancer"
    prometheusEnabled    = "false"
    mavenAgentTag        = "jdk11"
    chart-admin-username = "admin"
    chart-admin-password = "password"
    computer_jnlpmac     = "jenkins-agent"
    computer_name        = "jenkins-agent"
  })]

}

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
    computer_name        = "jenkins-agent"
  })]

}
