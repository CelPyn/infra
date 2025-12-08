resource "random_password" "authentik" {
  length = 32
}

resource "kubernetes_secret" "authentik_postgres_app" {
  metadata {
    name      = "authentik-pg-credentials"
    namespace = "authentik"
  }

  data = {
    username = "authentik"
    password = random_password.authentik.result
  }
}

resource "kubernetes_secret" "authentik_postgres_db" {

  metadata {
    name      = "authentik-pg-credentials"
    namespace = "postgres"
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

  metadata {
    name      = "authentik-signing-key"
    namespace = "authentik"
  }

  data = {
    key = random_password.authentik_signing_key.result
  }
}
