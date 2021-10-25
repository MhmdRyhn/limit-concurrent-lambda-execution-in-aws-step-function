variable "module" {
  type        = string
  description = "Name of the module or project."
}

variable "environment" {
  type        = string
  description = "Name of the environment, i.e., dev, nightly, stable, uat, staging, production etc."
}
