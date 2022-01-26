resource "yandex_kubernetes_node_group" "otus_project_group" {
  cluster_id  = yandex_kubernetes_cluster.zonal_cluster_resource_name.id
  name        = var.nodegroup_info.name
  version     = var.k8s_version
  description = var.nodegroup_info.description

  # labels = {
  #   "key" = "value"
  # }
  # node_taints = [
  #   "key=value:effect"
  # ]
  instance_template {
    platform_id = "standard-v2"
    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.subnet_resource_name.id}"]
    }
    resources {
      memory = var.nodegroup_info.memory
      cores  = var.nodegroup_info.cores
    }
    boot_disk {
      type = var.nodegroup_info.boot_disk_type
      size = var.nodegroup_info.boot_disk_size
    }
    scheduling_policy {
      preemptible = var.nodegroup_info.preemptible
    }
  }
  scale_policy {
    fixed_scale {
      size = var.nodegroup_info.group_size
    }
  }
  allocation_policy {
    location {
      zone = var.zone_id
    }
  }
  maintenance_policy {
    auto_upgrade = false
    auto_repair  = false
    maintenance_window {
      day        = "monday"
      start_time = "01:00"
      duration   = "3h"
    }
    maintenance_window {
      day        = "friday"
      start_time = "01:00"
      duration   = "4h30m"
    }
  }
}
