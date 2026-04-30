resource "aws_db_subnet_group" "default" {
  name = "hospital-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "hospitaldb"
  username             = "admin"
  password             = "Admin@12345"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
  publicly_accessible  = false

  tags = {
    Name = "Hospital-DB"
  }
}
