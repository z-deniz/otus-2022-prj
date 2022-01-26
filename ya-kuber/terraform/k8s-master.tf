resource "yandex_kubernetes_cluster" "zonal_cluster_resource_name" {
  name       = var.project_name
  network_id = yandex_vpc_network.this.id

  master {
    version = var.k8s_version
    zonal {
      zone      = yandex_vpc_subnet.subnet_resource_name.zone
      subnet_id = yandex_vpc_subnet.subnet_resource_name.id
    }
    public_ip = true
  }

  service_account_id      = var.sa_id
  node_service_account_id = var.sa_id
  release_channel         = "STABLE"
}

resource "yandex_vpc_network" "this" {}

resource "yandex_vpc_subnet" "subnet_resource_name" {
  network_id     = yandex_vpc_network.this.id
  zone           = var.zone_id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${yandex_kubernetes_cluster.zonal_cluster_resource_name.master[0].external_v4_endpoint}
    certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.zonal_cluster_resource_name.master[0].cluster_ca_certificate)}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: yc
  name: ycmk8s
current-context: ycmk8s
users:
- name: yc
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: yc
      args:
      - k8s
      - create-token
KUBECONFIG
}
output "kubeconfig" {
  value = local.kubeconfig
}
