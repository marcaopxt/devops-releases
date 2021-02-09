variable "KUBERNETES_TOKEN" {
    type        = string
    description = "Kubernetes Token normally on ~/.kube/token in local implementations"
    default    = "~/.kube/token"
}

variable "GITHUB_SSH_PRIVATE_KEY" {
    type        = string
    description = "Github's private key to use ssh protocol" 
    default     = "~/.ssh/id_rsa"
}