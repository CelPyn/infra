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
    clientID = data.aws_ssm_parameter.headlamp_oidc_client_id.value
    clientSecret = data.aws_ssm_parameter.headlamp_oidc_client_secret.value
    issuerURL = "https://auth.pynenborg.com/application/o/headlamp/"
    scopes = "email,openid,profile"
    callbackURL = "http://localhost:4466/oidc-callback"
  }
}
