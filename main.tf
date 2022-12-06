resource "null_resource" "password_admin_bcrypt" {
  triggers = {
    source = var.argocd_admin_password
    value  = bcrypt(var.argocd_admin_password)
  }

  lifecycle {
    ignore_changes = [triggers["value"]]
  }
}


resource "helm_release" "argocd" {
  name       = "argocd-${var.environment}"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version.helm
  #skip_crds  = true

  namespace = var.namespace

  set {
    name  = "server.ingress.enabled"
    value = true
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = var.main_domain
  }

  values = [
    <<-EOT
    configs:
      params:
        server.insecure: ${var.insecure}
    EOT
  ]

  set {
    name  = "dex.enabled"
    value = false
  }

  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = null_resource.password_admin_bcrypt.triggers["value"]
  }

}