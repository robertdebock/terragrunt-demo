terraform {
  source = "../modules"
}

inputs = {
  amount = 3
  size   = "s-16vcpu-64gb"
  name   = "production"
}
