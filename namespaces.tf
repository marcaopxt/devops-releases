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
resource "kubernetes_namespace" "postgresql" {
  metadata {
    annotations = {}
    labels = {}
    name = "postgresql"
  }
}
resource "kubernetes_namespace" "spark" {
  metadata {
    annotations = {}
    labels = {}
    name = "spark"
  }
}
resource "kubernetes_namespace" "kafka" {
  metadata {
    annotations = {}
    labels = {}
    name = "kafka"
  }
}

resource "kubernetes_namespace" "kong" {
  metadata {
    annotations = {}
    labels = {}
    name = "kong"
  }
}