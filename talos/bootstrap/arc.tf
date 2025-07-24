data "aws_ssm_parameter" "github_app_id" {
  name = "/homelab/saaspacho/arc/appId"
}

data "aws_ssm_parameter" "github_app_installation_id" {
  name = "/homelab/saaspacho/arc/installationId"
}

data "aws_ssm_parameter" "github_app_private_key" {
  name = "/homelab/saaspacho/arc/privateKey"
}

resource "kubernetes_secret" "arc" {
  metadata {
    name      = "arc-credentials"
    namespace = "arc"
  }

  binary_data = {
    github_app_id              = base64encode(data.aws_ssm_parameter.github_app_id.value)
    github_app_installation_id = base64encode(data.aws_ssm_parameter.github_app_installation_id.value)
    github_app_private_key     = base64encode(data.aws_ssm_parameter.github_app_private_key.value)
  }

  depends_on = [kubernetes_manifest.app_of_apps]
}
