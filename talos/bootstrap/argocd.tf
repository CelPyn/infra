resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "oci://ghcr.io/argoproj/argo-helm"
  chart      = "argo-cd"
  version    = "9.2.4"

  values = [
    templatefile("${path.module}/templates/argocd/values.yaml", {
      authentikClientSecret = data.aws_ssm_parameter.argocd_authentik_client_secret.value,
      sshPrivateKey         = indent(8, data.aws_ssm_parameter.argocd_ssh_key.value)
    })
  ]
}

resource "kubernetes_manifest" "app_of_apps" {
  manifest = yamldecode(templatefile("${path.module}/templates/app-of-apps.yaml", {}))

  depends_on = [helm_release.argocd]
}

data "aws_ssm_parameter" "argocd_authentik_client_secret" {
  name = "/homelab/gitops/argocd-authentik-client-secret"
}

data "aws_ssm_parameter" "argocd_ssh_key" {
  name = "/homelab/gitops/ssh-private-key"
}
