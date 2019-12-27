provider "aws" {
  region = var.aws_region
}

module "netbox-database" {
  source = "./netbox-database"
  name   = "./netbox-database"
  db_name = var.db_name
  db_user = var.db_user
  db_pass = var.db_pass
  security_groups = [aws_security_group.netbox-db.id]
  providers = {
    aws = aws
  }
}

module "netbox-instance" {
  source      = "./netbox-instance"
  name        = "./netbox-instance"
  domain_name = var.domain_name
  db_host = module.netbox-database.db-host
  db_name = module.netbox-database.db-name
  db_user = module.netbox-database.db-user
  db_pass = module.netbox-database.db-pass
  key_pair_location = var.key_pair_location
  key_pair_name   = var.key_pair_name
  security_groups = [aws_security_group.netbox-instance.id]
  cloudfront_ssl_acm_arn = var.cloudfront_ssl_acm_arn
  providers = {
    aws = aws
  }
}