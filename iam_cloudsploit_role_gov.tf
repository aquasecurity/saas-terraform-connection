data "aws_iam_policy_document" "cloudsploit_cross_account_role_document-gov" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws-us-gov:iam::099193770462:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        "${var.cloudsploit_external_id}"
      ]
    }
  }
}

resource "aws_iam_role" "cloudsploit_cross_account_role-gov" {
  name = "tf-cloudsploit"
  # disable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"
  assume_role_policy = data.aws_iam_policy_document.cloudsploit_cross_account_role_document-gov
}


resource "aws_iam_role_policy_attachment" "cloudsploit_cross_account_attach-gov" {
  # disable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"

  role       = aws_iam_role.cloudsploit_cross_account_role-gov[*].name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

