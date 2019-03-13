data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws-us${var.use_aws_gov ? "" : "-gov"}:iam::099193770462:root"]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = ["${var.cloudsploit_external_id}"]
    }
  }
}
