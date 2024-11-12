<?php
session_start();
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM teachers WHERE username = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $teacher = $result->fetch_assoc();

    if ($teacher && password_verify($password, $teacher['password_hash'])) {
        $_SESSION['teacher_id'] = $teacher['id'];
        $_SESSION['username'] = $teacher['username'];
        header("Location: teacher_dashboard.php");
        exit();
    } else {
        echo "Väärä käyttäjänimi tai salasana.";
    }
}
?>
