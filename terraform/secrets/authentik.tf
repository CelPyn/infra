resource "random_password" "authentik" {
  length = 32
}

resource "kubernetes_secret" "authentik_postgres" {
  for_each = toset(["postgres"])

  metadata {
    name      = "authentik-pg-credentials"
    namespace = each.value
  }

  data = {
    username = base64encode("authentik")
    password = base64encode(random_password.authentik.result)
  }

  type = "kubernetes.io/basic-auth"
}
