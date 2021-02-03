resource "helm_release" "postgresql" {
  name          = "postgresql"
  namespace     = "postgresql" 
  chart         = "postgresql"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = "10.2.6"
  reuse_values  = false
  recreate_pods = true
  force_update  = true

  values        = [templatefile("templates/postgresql-values.tpl.yaml", {
    serviceType             = "LoadBalancer"
    prometheusEnabled       = "false"
    mavenAgentTag           = "jdk11"
    chart-admin-username    = "admin"
    chart-admin-password    = "password"
    computer_jnlpmac        = "jenkins-agent"
    computer_name           = "jenkins-agent"
    agent_idle_minutes      = "15"
//    persistent_volume_claim = kubernetes_persistent_volume_claim.jenkins_workspace
  })]

}
