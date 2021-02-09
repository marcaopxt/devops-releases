variable "KUBERNETES_TOKEN" {
    type        = string
    description = "Kubernetes Token normally on ~/.kube/token in local implementations"
    default    = "~/.kube/token"
}