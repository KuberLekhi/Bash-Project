#!/bin/bash

# Variables
DB_ENDPOINT=$(aws rds describe-db-instances \
    --db-instance-identifier my-db-instance \
    --query 'DBInstances[0].Endpoint.Address' \
    --output text --region ap-south-1)
DB_USER="admin"
DB_PASS="admin1234"
DB_NAME="my-db"

# Wait for DB to be available
aws rds wait db-instance-available --db-instance-identifier my-db-instance --region ap-south-1

# Create a table if not exists
mysql -h $DB_ENDPOINT -u $DB_USER -p$DB_PASS -e "
CREATE DATABASE IF NOT EXISTS $DB_NAME;
USE $DB_NAME;
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    color VARCHAR(20)
);"

# Insert Data (Replace this with actual inputs)
mysql -h $DB_ENDPOINT -u $DB_USER -p$DB_PASS $DB_NAME -e "
INSERT INTO users (name, age, color) VALUES ('Kuber', 22, 'Blue');"
