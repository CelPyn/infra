resource "random_password" "authentik" {
  length = 32
}

resource "kubernetes_secret" "authentik_postgres" {
  for_each = toset(["authentik", "postgres"])

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

resource "random_password" "authentik_signing_key" {
  length = 50
}

resource "kubernetes_secret" "authentik_signing_key" {
  for_each = toset(["authentik"])

  metadata {
    name      = "authentik-signing-key"
    namespace = each.value
  }

  data = {
    key = random_password.authentik_signing_key.result
  }
}
