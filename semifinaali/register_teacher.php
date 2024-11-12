<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Tarkistetaan, onko käyttäjänimi jo olemassa
    $check_sql = "SELECT * FROM teachers WHERE username = ?";
    $stmt = $conn->prepare($check_sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo "Käyttäjänimi on jo käytössä. Valitse toinen käyttäjänimi.";
    } else {
        // Kryptataan salasana
        $password_hash = password_hash($password, PASSWORD_BCRYPT);
        $sql = "INSERT INTO teachers (username, password_hash) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $username, $password_hash);

        if ($stmt->execute()) {
            echo "Rekisteröinti onnistui. <a href='login.html'>Kirjaudu sisään</a>";
        } else {
            echo "Rekisteröinti epäonnistui. Yritä uudelleen.";
        }
    }
}
?>
