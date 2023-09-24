resource "aws_security_group" "elearning_db" {
  name        = "postgres-security-group"
  description = "Security group for Postgres database"
 
  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "elearning" {
  identifier             = "elearning"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "15.0"
  username               = var.db_user
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.elearning_db.id]
  skip_final_snapshot    = true
  deletion_protection    = false
}
