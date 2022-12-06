variable "namespace" {
  type = string
}

variable "environment" {
  type = string
}

variable "main_domain" {
  type        = string
  description = "main domain used for app urls"
}

variable "insecure" {
  type    = bool
  default = true
}

variable "argocd_admin_password" {
  type      = string
  #sensitive = true
}

variable "argocd_version" {
}