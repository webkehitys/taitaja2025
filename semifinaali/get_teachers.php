<?php
include 'db.php';

$sql = "SELECT id, username FROM teachers";
$result = $conn->query($sql);
$teachers = [];
while ($row = $result->fetch_assoc()) {
    $teachers[] = $row;
}
echo json_encode($teachers);
?>
