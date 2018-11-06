# CloudSploit Terraform Modules

This Terraform module is responsible for provisioning CloudSploit IAM resources(IAM trust/roles).

This module is considered a *Global* module and only needs to be provisioned 1 time per AWS Account. 

## Incorporating this Module
* Add this code to your provider file
* The **account_id** must be set & passed from the root module.
* The **cloudsploit_external_id** must be obtained from CloudSploit and different AWS accounts have different external IDs.

```
module "cloudsploit" {
  source                  = "git@github.com:cloudsploit/cloudsploit-terrform-scans.git"
  account_id              = "${var.account_id}"
  cloudsploit_external_id = "${var.cloudsploit_external_id}"
}
```

## Outputs
* **cloudsploit_cross_account_role_arn** - Cloudsploit cross account trust role.
