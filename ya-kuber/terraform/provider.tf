terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  #   token     = var.token_id
  #   cloud_id  = "$YC_CLOUD_ID"
  #   folder_id = "$YC_FOLDER_ID"
  zone = var.zone_id
}
