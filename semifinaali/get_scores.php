<?php
include 'db.php';

// Tarkistetaan, onko category_id annettu
if (!isset($_GET['category_id'])) {
    echo json_encode(["error" => "category_id parametri puuttuu"]);
    exit();
}

$category_id = intval($_GET['category_id']);

// SQL-kysely, joka hakee parhaat tulokset ja niihin liittyvät opettajan ja kategorian nimet
$sql = "
    SELECT 
        scores.student_name, 
        scores.score, 
        categories.name AS category_name, 
        teachers.username AS teacher_name
    FROM scores
    INNER JOIN categories ON scores.category_id = categories.id
    INNER JOIN teachers ON scores.teacher_id = teachers.id
    WHERE scores.category_id = $category_id
    ORDER BY scores.score DESC, scores.date DESC
    LIMIT 10
";

$result = $conn->query($sql);

// Tarkista, onko kysely onnistunut
if (!$result) {
    echo json_encode(["error" => "Database query failed: " . $conn->error]);
    exit();
}

$scores = [];
while ($row = $result->fetch_assoc()) {
    $scores[] = $row;
}

// Palautetaan JSON-vastaus, joka sisältää kaikki tiedot
echo json_encode($scores);
?>
