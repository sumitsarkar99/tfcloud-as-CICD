terraform {
  cloud {
    organization = "newtf-ss"

    workspaces {
      name = "Git-demo-ss"
    }
  }
}