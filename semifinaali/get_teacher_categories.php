<?php
session_start();
include 'db.php';

// Varmistetaan, että opettajan ID on asetettu sessiossa
if (!isset($_SESSION['teacher_id'])) {
    http_response_code(403);
    echo json_encode(["error" => "Unauthorized"]);
    exit();
}

$teacher_id = $_SESSION['teacher_id'];
$sql = "SELECT * FROM categories WHERE teacher_id = $teacher_id";
$result = $conn->query($sql);

if ($result === false) {
    echo json_encode(["error" => "Database query failed"]);
    exit();
}

$categories = [];
while ($row = $result->fetch_assoc()) {
    $categories[] = $row;
}

// Palautetaan JSON-muodossa kategoriat
echo json_encode($categories);
?>
