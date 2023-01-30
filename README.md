# terraform-argocd-install
Install Argocd on Kubernetes Cluster / EKS Cluster (AWS)

How to use it
```
module "argocd" {
  source                 = "git::https://github.com/taulanthalili/terraform-argocd-install.git?ref=main"
  namespace              = module.data.namespace
  environment            = module.data.environment
  main_domain            = module.data.argocd_domain
  argocd_admin_password  = sensitive(module.data.argocd_admin_password)
  argocd_version         = module.data.argocd_version
}
```
