data "aws_iam_policy_document" "cloudsploit_supplemental_iam_policy" {
  statement {
    sid       = "CloudSploitSupplemental"
    actions   = [
        "athena:GetWorkGroup",
        "cloudwatchlogs:DescribeLogGroups",
        "cloudwatchlogs:DescribeMetricFilters",
        "elastictranscoder:ListPipelines",
        "ses:DescribeActiveReceiptRuleSet"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudsploit_supplemental_iam_policy" {
  name        = "cloudsploit-supplemental-policy"
  description = "CloudSploit Supplemental IAM Policy for Additional Scans"
  policy      = "${data.aws_iam_policy_document.cloudsploit_supplemental_iam_policy.json}"
}

resource "aws_iam_role_policy_attachment" "cloudsploit_supplemental_attach" {
  # disable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 0 : 1}"

  role       = "${aws_iam_role.cloudsploit_cross_account_role.name}"
  policy_arn = "${aws_iam_policy.cloudsploit_supplemental_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "cloudsploit_supplemental_attach-gov" {
  # enable this if use_aws_gov == true
  count = "${var.use_aws_gov ? 1 : 0}"

  role       = "${aws_iam_role.cloudsploit_cross_account_role-gov.name}"
  policy_arn = "${aws_iam_policy.cloudsploit_supplemental_iam_policy.arn}"
}