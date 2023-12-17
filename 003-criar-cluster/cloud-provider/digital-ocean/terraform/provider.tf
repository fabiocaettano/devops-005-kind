terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "token" {}
variable "clustername" {}
variable "region" {}
variable "k8s_version" {}
variable "pool_name" {}
variable "node_count" {}
variable "size" {}

provider "digitalocean" {
    token = var.token  
}

resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
    name = var.clustername
    region = var.region
    version = var.k8s_version
    tags = ["k8s"]

    node_pool {
      name = var.pool_name
      size = var.size
      auto_scale = false
      node_count = var.node_count
      tags = ["node-pool-tag"]
    }    
}