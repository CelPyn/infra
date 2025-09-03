data "aws_ssm_parameter" "tailscale_oauth_client_id" {
  name = "/homelab/tailscale/oauth/clientId"
}

data "aws_ssm_parameter" "tailscale_oauth_client_secret" {
  name = "/homelab/tailscale/oauth/clientSecret"
}

resource "kubernetes_secret" "tailsscale_oauth" {
  metadata {
    name      = "operator-oauth"
    namespace = "tailscale"
  }

  data = {
    client_id: data.aws_ssm_parameter.tailscale_oauth_client_id.value
    client_secret: data.aws_ssm_parameter.tailscale_oauth_client_secret.value
  }

  depends_on = [kubernetes_manifest.app_of_apps]
}
