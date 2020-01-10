resource "aws_db_instance" "netbox-database" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "9.6.10"
  instance_class          = "db.t2.micro"
  identifier              = "netbox-db"
  name                    = var.db_name
  username                = var.db_user
  password                = var.db_pass
  backup_retention_period = 120
  vpc_security_group_ids    = var.security_groups
  final_snapshot_identifier = var.db_name_final-snapshot

#lifecycle {
#    prevent_destroy = true
#  }

  tags = {
    Name = var.name
  }
}