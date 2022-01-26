variable "folder_id" {
  type        = string
  description = "folder_id"
}

variable "sa_name" {
  type        = string
  description = "Service account name"
}
variable "sa_id" {
  type        = string
  description = "Service account id"
}
variable "zone_id" {
  type        = string
  description = "Service account name"
}

variable "k8s_version" {
  type        = string
  description = "K8S Version"
  default     = "1.20"
}

variable "project_name" {
  type        = string
  description = "k8s project name"
  default     = "otus-project"
}

variable "nodegroup_info" {
  type        = map(any)
  description = "k8s nodegroup name"
  default = {
    name           = "otus-project-nodes"
    description    = "Nodes OTUS"
    memory         = 4
    cores          = 2
    group_size     = 2
    boot_disk_type = "network-hdd"
    boot_disk_size = 64
    preemptible    = false
  }
}
