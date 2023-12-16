output "vm" {
  value = {
    for droplet in digitalocean_droplet.vm:
    droplet.name => droplet.ipv4_address
  }
}