resource "aws_iam_role" "cloudsploit_cross_account_role-gov" {
  name = "tf-cloudsploit"

  # enable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws-us-gov:iam::099193770462:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.cloudsploit_external_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudsploit_cross_account_attach-gov" {
  # enable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"

  role       = "${aws_iam_role.cloudsploit_cross_account_role-gov[count.index].name}"
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
