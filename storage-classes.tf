/*
resource "kubernetes_storage_class" "fast" {
  metadata {
    name = "fast"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Delete"

  parameters = {
    type = "pd-ssd"
  }
}

resource "kubernetes_storage_class" "fast-persistent" {
  metadata {
    name = "fast-persistent"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type = "pd-ssd"
  }
}

resource "kubernetes_storage_class" "fast-persistent-replicated" {
  metadata {
    name = "fast-persistent-replicated"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type             = "pd-ssd"
    replication-type = "regional-pd"
  }
}

resource "kubernetes_storage_class" "standard-persistent" {
  metadata {
    name = "standard-persistent"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type = "pd-standard"
  }
}

resource "kubernetes_storage_class" "standard-persistent-replicated" {
  metadata {
    name = "standard-persistent-replicated"
  }

  storage_provisioner = "kubernetes.io/gce-pd"
  reclaim_policy      = "Retain"

  parameters = {
    type             = "pd-standard"
    replication-type = "regional-pd"
  }
}
*/

data "kubernetes_storage_class" "hostpath" {
  metadata {
    name = "hostpath"
  }
  reclaim_policy      = "Retain"
}