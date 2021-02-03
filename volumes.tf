resource "kubernetes_persistent_volume" "jenkins_workspace_volume" {
  metadata {
    name = "jenkins-workspace-volume"
  }
  spec {
    capacity = {
      storage = "8Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      local {
        path = "/home/mpeixoto/jenkins-workspaces"
      }
    }    
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
/*
resource "kubernetes_persistent_volume_claim" "jenkins_workspace" {
  metadata {
    name      = "jenkins-workspace"
    namespace = "jenkins"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "8Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.jenkins_workspace_volume.metadata[0].name
    storage_class_name = "hostpath"
  }
}
*/