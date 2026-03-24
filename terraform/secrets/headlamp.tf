data "aws_ssm_parameter" "headlamp_oidc_client_id" {
  name = "/homelab/headlamp/oidc/clientID"
}

data "aws_ssm_parameter" "headlamp_oidc_client_secret" {
  name = "/homelab/headlamp/oidc/clientSecret"
}

resource "kubernetes_secret" "headlamp_oidc" {
  metadata {
    name      = "oidc"
    namespace = "headlamp"
  }

  data = {
    OIDC_CLIENT_ID = data.aws_ssm_parameter.headlamp_oidc_client_id.value
    OIDC_CLIENT_SECRET = data.aws_ssm_parameter.headlamp_oidc_client_secret.value
    OIDC_ISSUER_URL = "https://auth.pynenborg.com/application/o/headlamp/"
    OIDC_CALLBACK_URL = "http://localhost:8080/oidc-callback"
    OIDC_USE_ACCESS_TOKEN = "true"
  }
}
