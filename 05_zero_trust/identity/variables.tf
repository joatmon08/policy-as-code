variable "project" {
  type = object({
    gcp   = string
    aws   = string
    azure = string
  })
}

variable "users" {
  type = object({
    owner  = list(string)
    editor = list(string)
    reader = list(string)
  })
}

variable "access_mappings" {
  type = object({
    owner = object({
      gcp   = string
      aws   = string
      azure = string
    })
    editor = object({
      gcp   = string
      aws   = string
      azure = string
    })
    reader = object({
      gcp   = string
      aws   = string
      azure = string
    })
  })
  default = {
    owner = {
      gcp   = "owner"
      aws   = "AdministratorAccess"
      azure = "Owner"
    }
    editor = {
      gcp   = "editor"
      aws   = "SystemAdministrator"
      azure = "Contributor"
    }
    reader = {
      gcp   = "reader"
      aws   = "ReadOnlyAccess"
      azure = "Reader"
    }
  }
}