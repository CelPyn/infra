resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "oci://ghcr.io/argoproj/argo-helm"
  chart      = "argo-cd"
  version    = "7.5.0"

  values = [
    templatefile("${path.module}/templates/argocd/values.yaml", {
      sshPrivateKey = indent(8, data.aws_secretsmanager_secret_version.argocd_ssh_key.secret_string)
    })
  ]
}

# resource "kubernetes_manifest" "app_of_apps" {
#   manifest = yamldecode(templatefile("${path.module}/templates/app-of-apps.yaml", {}))
#
#   depends_on = [helm_release.argocd]
# }

data "aws_secretsmanager_secret" "argocd_ssh_key" {
  name = "homelab/gitops/ssh-private-key"
}

data "aws_secretsmanager_secret_version" "argocd_ssh_key" {
  secret_id = data.aws_secretsmanager_secret.argocd_ssh_key.id
}
