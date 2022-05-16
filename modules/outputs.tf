output "name" {
  value = digitalocean_droplet.default[*].ipv4_address
}
