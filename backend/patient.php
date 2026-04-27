<?php
include 'db.php';

$name = $_POST['patient_name'];

$sql = "INSERT INTO patients (name) VALUES ('$name')";

if ($conn->query($sql) === TRUE) {
    echo "Patient Registered Successfully";
} else {
    echo "Error";
}
?>
