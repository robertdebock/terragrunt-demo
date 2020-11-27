variable "amount" {
  description = "The number of instances to create."
}

variable "size" {
  description = "The size of the instance(s) to create."
}

variable "name" {
  description = "The name of the instance(s) to create."
}

module "ssh_key" {
  source     = "robertdebock/ssh_key/digitalocean"
  version    = "2.0.0"
  name       = "Robert de Bock"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWswOogkZz/ihQA0lENCwDwSzmtmBWtFwzIzDlfa+eb4rBt6rZBg7enKeMqYtStI/NDneBwZUFBDIMu5zJTbvg7A60/WDhWXZmU21tZnm8K7KREFYOUndc6h//QHig6IIaIwwBZHF1NgXLtZ0qrUUlNU5JSEhDJsObMlPHtE4vFP8twPnfc7hxAnYma5+knU6qTMCDvhBE5tGJdor4UGeAhu+SwSVDloYtt1vGTmnFn8M/OD/fRMksusPefxyshJ37jpB4jY/Z9vzaNHwcj33prwl1b/xRfxr/+KRJsyq+ZKs9u2TVw9g4p+XLdfDtzZ8thR2P3x3MFrZOdFmCbo/5"
}

module "droplet" {
  source   = "robertdebock/droplet/digitalocean"
  version  = "1.0.0"
  name     = "${var.name}-${count.index}"
  ssh_keys = [module.ssh_key.id]
  count    = var.amount
  size     = var.size
}

data "cloudflare_zones" "default" {
  filter {
    name = "meinit.nl"
  }
}

module "record" {
  source  = "robertdebock/record/cloudflare"
  version = "1.0.0"
  name    = "${var.name}-${count.index}"
  type    = "A"
  value   = module.droplet[count.index].ipv4_address
  zone_id = data.cloudflare_zones.default.zones[0].id
  count   = var.amount
}

output "name" {
  value = module.record.*.hostname
}
