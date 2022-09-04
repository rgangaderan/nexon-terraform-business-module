terraform {
  required_version = ">= 0.14"
   experiments     = [module_variable_optional_attrs]

  required_providers {
    aws = "~> 3.69"
  }
}
