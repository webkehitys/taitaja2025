<?php
include 'db.php';
header('Content-Type: application/json');

// Lue POST-pyynnön data
$data = json_decode(file_get_contents('php://input'), true);

// Tarkista, että kaikki tarvittavat tiedot ovat mukana
if (
    isset($data['teacher_id']) && 
    isset($data['category_id']) && 
    isset($data['question']) && 
    isset($data['option_a']) && 
    isset($data['option_b']) && 
    isset($data['option_c']) && 
    isset($data['option_d']) && 
    isset($data['correct_option'])
) {
    $teacher_id = intval($data['teacher_id']);
    $category_id = intval($data['category_id']);
    $question = $conn->real_escape_string($data['question']);
    $option_a = $conn->real_escape_string($data['option_a']);
    $option_b = $conn->real_escape_string($data['option_b']);
    $option_c = $conn->real_escape_string($data['option_c']);
    $option_d = $conn->real_escape_string($data['option_d']);
    $correct_option = $conn->real_escape_string($data['correct_option']);

    // Lisää kysymys tietokantaan
    $sql = "INSERT INTO questions (teacher_id, category_id, question, option_a, option_b, option_c, option_d, correct_option) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iissssss", $teacher_id, $category_id, $question, $option_a, $option_b, $option_c, $option_d, $correct_option);

    if ($stmt->execute()) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "error" => $stmt->error]);
    }

    $stmt->close();
} else {
    // Debugging: Lähetetään virheelliset tiedot takaisin
    echo json_encode([
        "success" => false, 
        "error" => "Virheellinen syöte",
        "received_data" => $data
    ]);
}

$conn->close();
