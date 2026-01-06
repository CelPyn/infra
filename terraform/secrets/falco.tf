data "aws_ssm_parameter" "telegram_chatid" {
  name = "/homelab/telegram/chatid"
}

data "aws_ssm_parameter" "telegram_token" {
  name = "/homelab/telegram/token"
}

resource "kubernetes_secret" "telegram_credentials" {
  metadata {
    name      = "telegram-credentials"
    namespace = "falco"
  }

  data = {
    chat-id = data.aws_ssm_parameter.telegram_chatid.value
    token = data.aws_ssm_parameter.telegram_token.value
  }
}
