/***************************************
* GKE Cluster
***************************************/

resource "google_container_cluster" "primary" {
  name     = var.gcp_cluster_name
  location = var.gcp_cluster_location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  /*
  cluster_autoscaling {
    enabled = true

    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 4
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 16
    }
  }
  */
}

/***************************************
* GKE Node Pool
***************************************/

resource "google_container_node_pool" "node_pool" {
  name       = "pool-1"
  location   = var.gcp_cluster_location
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible     = false
    machine_type    = "e2-medium"
    service_account = var.gcp_cluster_service_account
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    tags            = []
  }

  autoscaling {
    max_node_count = 4
    min_node_count = 2
  }
}