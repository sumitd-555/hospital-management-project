<?php

$conn = new mysqli(
    "your-rds-endpoint",
    "admin",
    "Hospital123",
    "hospitaldb"
);

if ($conn->connect_error) {
    die("Connection Failed");
}
?>
