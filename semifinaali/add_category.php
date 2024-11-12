<?php
session_start();
include 'db.php';

if (!isset($_SESSION['teacher_id'])) {
    http_response_code(403);
    echo "Unauthorized";
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);
$name = $conn->real_escape_string($data['name']);
$teacher_id = $_SESSION['teacher_id'];

$sql = "INSERT INTO categories (name, teacher_id) VALUES ('$name', $teacher_id)";
$conn->query($sql);
?>
