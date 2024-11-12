<?php
include 'db.php';

if (!isset($_GET['teacher_id'])) {
    echo json_encode([]);
    exit();
}

$teacher_id = intval($_GET['teacher_id']);

$sql = "SELECT * FROM categories WHERE teacher_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $teacher_id);
$stmt->execute();
$result = $stmt->get_result();
$categories = [];
while ($row = $result->fetch_assoc()) {
    $categories[] = $row;
}
echo json_encode($categories);
?>
