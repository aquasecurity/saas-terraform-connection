output "cloudsploit_cross_account_role_arn" {
  value = "${aws_iam_role.cloudsploit_cross_account_role.*.arn}"

  # disable output for this resource if we are using aws gov
  count = "${var.use_aws_gov ? 0 : 1}"
}

output "cloudsploit_cross_account_role_arn-gov" {
  value = "${aws_iam_role.cloudsploit_cross_account_role-gov.*.arn}"

  # enable output for this resource if we are using aws gov
  count = "${var.use_aws_gov ? 1 : 0}"
}
