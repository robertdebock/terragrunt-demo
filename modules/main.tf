resource "digitalocean_ssh_key" "default" {
  name       = "Terragrunt"
  public_key = file("id_rsa.pub")
}

resource "digitalocean_droplet" "default" {
  count    = var.amount
  image    = "ubuntu-18-04-x64"
  name     = "${var.name}-${count.index}"
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}
