terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }  
}

variable "token" {}
variable "pvt_key" {}
variable "name_key" {}
variable "user" {}
variable "image" {}
variable "region" {}
variable "size" {}

provider "digitalocean" {
  token = var.token
}

data "digitalocean_ssh_key" "terraform" {
  name = var.name_key
}

