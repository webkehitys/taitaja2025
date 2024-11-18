<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['id'], $data['question'])) {
    $id = intval($data['id']);
    $question = $conn->real_escape_string($data['question']);

    $sql = "UPDATE questions SET question='$question' WHERE id=$id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "error" => $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "error" => "Invalid data"]);
}
?>
