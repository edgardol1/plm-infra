variable "project_id" { type = string }

variable "region" {
  type    = string
  default = "us-central1"
}

variable "func_name" { type = string }   # ej: "ec41-uploader"
variable "sa_email"  { type = string }   # ej: "cf-caller@leadgen-plm-prod-01.iam.gserviceaccount.com"
