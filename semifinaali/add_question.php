<?php
session_start();
include 'db.php';

if (!isset($_SESSION['teacher_id'])) {
    http_response_code(403);
    echo "Unauthorized";
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);
$category_id = intval($data['category_id']);
$teacher_id = $_SESSION['teacher_id'];
$question = $conn->real_escape_string($data['question']);
$option_a = $conn->real_escape_string($data['option_a']);
$option_b = $conn->real_escape_string($data['option_b']);
$option_c = $conn->real_escape_string($data['option_c']);
$option_d = $conn->real_escape_string($data['option_d']);
$correct_option = $conn->real_escape_string($data['correct_option']);

$sql = "INSERT INTO questions (category_id, teacher_id, question, option_a, option_b, option_c, option_d, correct_option) 
        VALUES ($category_id, $teacher_id, '$question', '$option_a', '$option_b', '$option_c', '$option_d', '$correct_option')";
$conn->query($sql);
?>
