resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

data "aws_ssm_parameter" "grafana_url" {
  name = "/homelab/monitoring/grafana/url"
}

data "aws_ssm_parameter" "grafana_username" {
  name = "/homelab/monitoring/grafana/username"
}

data "aws_ssm_parameter" "grafana_password" {
  name = "/homelab/monitoring/grafana/password"
}

resource "kubernetes_secret" "monitoring" {
  metadata {
    name      = "grafana-credentials"
    namespace = "monitoring"
  }

  binary_data = {
    url      = base64encode(data.aws_ssm_parameter.grafana_url.value),
    username = base64encode(data.aws_ssm_parameter.grafana_username.value),
    password = base64encode(data.aws_ssm_parameter.grafana_password.value)
  }
}
