output "cloudsploit_cross_account_role_arn" {
  value = "${aws_iam_role.cloudsploit_cross_account_role.*.arn}"
}

output "cloudsploit_cross_account_role_arn-gov" {
  value = "${aws_iam_role.cloudsploit_cross_account_role-gov.*.arn}"
}
