<?php
session_start();
include 'db.php';

// Tarkista, että lomakkeen tiedot on annettu
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['username'], $_POST['password'])) {
    $username = $conn->real_escape_string($_POST['username']);
    $password = $_POST['password'];

    // Hae käyttäjä tietokannasta
    $sql = "SELECT id, username, password_hash FROM teachers WHERE username = '$username'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();

        // Tarkista salasana
        if (password_verify($password, $user['password_hash'])) {
            // Aseta istuntomuuttujat
            $_SESSION['teacher_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];

            // Ohjaa opettajan hallintapaneeliin
            header("Location: teacher_dashboard.php");
            exit();
        } else {
            $error = "Väärä käyttäjätunnus tai salasana.";
        }
    } else {
        $error = "Väärä käyttäjätunnus tai salasana.";
    }
} else {
    $error = "Täytä molemmat kentät.";
}

// Jos kirjautuminen epäonnistuu, näytä virheviesti
$_SESSION['login_error'] = $error;
header("Location: login.html");
exit();
?>
