<?php
include 'db.php';

$data = json_decode(file_get_contents('php://input'), true);
$student_name = $conn->real_escape_string($data['student_name']);
$score = intval($data['score']);
$category_id = intval($data['category_id']);

// Hae opettajan ID category_id:n perusteella
$sql = "SELECT teacher_id FROM categories WHERE id = $category_id";
$result = $conn->query($sql);
$teacher = $result->fetch_assoc();
$teacher_id = $teacher['teacher_id'];

// Tallennetaan opiskelijan tulos `scores`-tauluun
$sql = "INSERT INTO scores (student_name, score, category_id, teacher_id) VALUES ('$student_name', $score, $category_id, $teacher_id)";
$conn->query($sql);
?>
