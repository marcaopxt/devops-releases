/*
resource "kubernetes_persistent_volume" "jenkins_workspace" {
  metadata {
    name      = "jenkins-workspace"
    annotations = {
      "meta.helm.sh/release-name": "jenkins"
      "meta.helm.sh/release-namespace": "jenkins"
    }    
    labels = {
      "app.kubernetes.io/managed-by": "Helm"
    }
  }
  spec {
    capacity = {
      storage = "8Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      local {
        path = "/var/lib/jenkins-workspace"
      }
    }    
    storage_class_name = "hostpath"
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "kubernetes.io/hostname"
            operator = "In"
            values = ["docker-desktop"]  # must mnanually put this one in
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins_workspace" {
  metadata {
    name      = "jenkins-workspace"
    namespace = "jenkins"
    annotations = {
      "meta.helm.sh/release-name": "jenkins"
      "meta.helm.sh/release-namespace": "jenkins"
    }
    labels = {
      "app.kubernetes.io/managed-by": "Helm"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "8Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.jenkins_workspace.metadata[0].name
    storage_class_name = "hostpath"
  }
}
*/