resource "digitalocean_droplet" "vm" {
  count = 1
  image = var.image
  name  = "vm-${count.index}"
  region = var.region
  size = var.size

  ssh_keys = [
    data.digitalocean_ssh_key.terraform.fingerprint
  ]

  connection {
    host = self.ipv4_address
    user = var.user
    type = "ssh"    
    agent = true
    timeout = "3m"
  }
}
