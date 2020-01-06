resource "aws_iam_role" "cloudsploit_cross_account_role" {
  name = "tf-cloudsploit"

  # disable this if use_aws_gov == true
  count = var.use_aws_gov ? 0 : 1

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::057012691312:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "var.cloudsploit_external_id"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudsploit_cross_account_attach" {
  # disable this if use_aws_gov == true
  count = var.use_aws_gov ? 0 : 1

  role       = aws_iam_role.cloudsploit_cross_account_role.*.name[count.index]
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
