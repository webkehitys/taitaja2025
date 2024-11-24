<?php
include 'db.php';
header('Content-Type: application/json');

// Tarkista, että tarvittavat parametrit ovat mukana
if (!isset($_GET['category']) || !isset($_GET['teacher_id'])) {
    echo json_encode(["success" => false, "error" => "Parametrit puuttuvat"]);
    exit();
}

$category_id = intval($_GET['category']);
$teacher_id = intval($_GET['teacher_id']);

// Hae kysymykset tietokannasta
$sql = "SELECT id, question, option_a, option_b, option_c, option_d, correct_option 
        FROM questions 
        WHERE category_id = ? AND teacher_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $category_id, $teacher_id);
$stmt->execute();
$result = $stmt->get_result();

$questions = [];
while ($row = $result->fetch_assoc()) {
    $questions[] = $row;
}

echo json_encode($questions);
$conn->close();
