data "aws_iam_policy_document" "cloudsploit_cross_account_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::057012691312:root"]
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

resource "aws_iam_role" "cloudsploit_cross_account_role" {
  name = "tf-cloudsploit"
  # disable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"
  assume_role_policy = data.aws_iam_policy_document.cloudsploit_cross_account_role_document
}


resource "aws_iam_role_policy_attachment" "cloudsploit_cross_account_attach" {
  # disable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"

  role       = aws_iam_role.cloudsploit_cross_account_role[*].name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
