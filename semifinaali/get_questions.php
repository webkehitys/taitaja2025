<?php
include 'db.php';

$category_id = intval($_GET['category']);
$teacher_id = intval($_GET['teacher_id']);

$sql = "SELECT * FROM questions WHERE category_id = $category_id AND teacher_id = $teacher_id";
$result = $conn->query($sql);
$questions = [];
while ($row = $result->fetch_assoc()) {
    $questions[] = $row;
}
echo json_encode($questions);
?>
