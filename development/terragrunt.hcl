terraform {
  source = "../modules"
}

inputs = {
  amount = 1
  size   = "s-1vcpu-1gb"
  name   = "development"
}
