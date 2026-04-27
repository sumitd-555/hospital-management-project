<?php

$conn = new mysqli(
    "your-rds-endpoint",
    "admin",
    "Admin@12345",
    "hospitaldb"
);

if ($conn->connect_error) {
    die("Connection Failed");
}
?>
