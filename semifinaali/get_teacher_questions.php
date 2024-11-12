<?php
session_start();
include 'db.php';

if (!isset($_SESSION['teacher_id'])) {
    http_response_code(403);
    echo "Unauthorized";
    exit();
}

$category_id = intval($_GET['category_id']);
$teacher_id = $_SESSION['teacher_id'];

$sql = "SELECT * FROM questions WHERE category_id = $category_id AND teacher_id = $teacher_id";
$result = $conn->query($sql);
$questions = [];
while ($row = $result->fetch_assoc()) {
    $questions[] = $row;
}
echo json_encode($questions);
?>
