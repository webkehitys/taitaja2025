<?php
include 'db.php';
header('Content-Type: application/json');

// Hae tiedot POST-pyynnöstä
$data = json_decode(file_get_contents('php://input'), true);

if (
    isset($data['category_id'], $data['question'], $data['option_a'], $data['option_b'], $data['option_c'], $data['option_d'], $data['correct_option'])
) {
    $category_id = intval($data['category_id']);
    $question = $conn->real_escape_string($data['question']);
    $option_a = $conn->real_escape_string($data['option_a']);
    $option_b = $conn->real_escape_string($data['option_b']);
    $option_c = $conn->real_escape_string($data['option_c']);
    $option_d = $conn->real_escape_string($data['option_d']);
    $correct_option = $conn->real_escape_string($data['correct_option']);

    // Lisää kysymys tietokantaan
    $sql = "INSERT INTO questions (category_id, question, option_a, option_b, option_c, option_d, correct_option) 
            VALUES ($category_id, '$question', '$option_a', '$option_b', '$option_c', '$option_d', '$correct_option')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "error" => $conn->error]);
    }
} else {
    echo json_encode(["success" => false, "error" => "Virheellinen syöte"]);
}
$conn->close();
?>
