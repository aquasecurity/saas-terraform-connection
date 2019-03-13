resource "aws_iam_role" "cloudsploit_cross_account_role" {
  name = "tf-cloudsploit"

  # disable this if use_aws_gov == true
  count              = "${var.use_aws_gov ? 0 : 1}"
  assume_role_policy = "${data.aws_iam_policy_document.cross_account_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "cloudsploit_cross_account_attach" {
  # disable this if use_aws_gov == true
  count      = "${var.use_aws_gov ? 0 : 1}"
  role       = "${aws_iam_role.cloudsploit_cross_account_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
