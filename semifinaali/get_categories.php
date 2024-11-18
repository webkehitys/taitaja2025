<?php
include 'db.php';

if (isset($_GET['teacher_id'])) {
    $teacher_id = intval($_GET['teacher_id']);

    $sql = "SELECT id, name FROM categories WHERE teacher_id = $teacher_id";
    $result = $conn->query($sql);

    $categories = [];
    while ($row = $result->fetch_assoc()) {
        $categories[] = $row;
    }

    echo json_encode($categories);
} else {
    echo json_encode(["error" => "Teacher ID missing"]);
}
?>
