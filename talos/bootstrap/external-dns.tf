resource "aws_iam_user" "external-dns" {
  name = "external-dns"
}

resource "aws_iam_access_key" "external-dns" {
  user = aws_iam_user.external-dns.name
}

resource "aws_iam_user_policy_attachment" "external-dns" {
  user       = aws_iam_user.external-dns.name
  policy_arn = aws_iam_policy.allow-external-dns.arn
}

resource "aws_iam_policy" "allow-external-dns" {
  name        = "allow-external-dns-dns"
  description = "Allows modifying DNS records"
  policy      = data.aws_iam_policy_document.allow-external-dns.json
}

data "aws_iam_policy_document" "allow-external-dns" {
  statement {
    effect = "Allow"
    sid    = "AllowRoute53"

    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "route53:ChangeResourceRecordSets",
    ]

    resources = ["*"]
  }
}

# resource "kubernetes_secret" "external-dns-credentials" {
#   metadata {
#     name      = "aws-credentials"
#     namespace = "external-dns"
#   }
#
#   binary_data = {
#     credentials = base64encode(
#       templatefile("${path.module}/templates/external-dns/credentials", {
#         accessKeyId     = aws_iam_access_key.external-dns.id,
#         secretAccessKey = aws_iam_access_key.external-dns.secret
#       })
#     )
#   }
#
#   depends_on = [kubernetes_manifest.app_of_apps]
# }
