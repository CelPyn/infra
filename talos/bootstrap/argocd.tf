resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "oci://ghcr.io/argoproj/argo-helm"
  chart      = "argo-cd"
  version    = "8.0.0"

  values = [
    templatefile("${path.module}/templates/argocd/values.yaml", {
      sshPrivateKey = indent(8, data.aws_ssm_parameter.argocd_ssh_key.value)
    })
  ]
}

resource "kubernetes_manifest" "app_of_apps" {
  manifest = yamldecode(templatefile("${path.module}/templates/app-of-apps.yaml", {}))

  depends_on = [helm_release.argocd]
}

data "aws_ssm_parameter" "argocd_ssh_key" {
  name = "/homelab/gitops/ssh-private-key"
}
