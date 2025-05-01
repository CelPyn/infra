resource "aws_iam_user" "cert-manager" {
  name = "cert-manager"
}

resource "aws_iam_access_key" "cert-manager" {
  user = aws_iam_user.cert-manager.name
}

resource "aws_iam_user_policy_attachment" "cert-manager" {
  user       = aws_iam_user.cert-manager.name
  policy_arn = aws_iam_policy.allow-cert-manager.arn
}

resource "aws_iam_policy" "allow-cert-manager" {
  name        = "allow-cert-manager-dns"
  description = "Allows modifying DNS records"
  policy      = data.aws_iam_policy_document.allow-cert-manager.json
}

data "aws_iam_policy_document" "allow-cert-manager" {
  statement {
    actions = [
      "route53:GetChange"
    ]
    resources = [
      "arn:aws:route53:::change/*",
    ]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*",
    ]
  }

  statement {
    actions = [
      "route53:ListHostedZonesByName",
    ]
    resources = [
      "*",
    ]
  }
}

# resource "kubernetes_secret" "cert-manager-credentials" {
#   metadata {
#     name = "aws-credentials"
#     namespace = "cert-manager"
#   }
#
#   data = {
#     accessKeyId = aws_iam_access_key.cert-manager.id,
#     secretAccessKey = aws_iam_access_key.cert-manager.secret
#   }
#
#   depends_on = [kubernetes_manifest.app_of_apps]
# }
