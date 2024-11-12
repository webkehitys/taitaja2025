<?php
session_start();
include 'db.php';

if (!isset($_SESSION['teacher_id'])) {
    header("Location: login.html");
    exit();
}

$teacher_id = $_SESSION['teacher_id'];
?>

<!DOCTYPE html>
<html lang="fi">
<head>
    <meta charset="UTF-8">
    <title>Opettajan Hallintapaneeli</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="dashboard-container">
        <h1>Tervetuloa, <?php echo $_SESSION['username']; ?></h1>

        <section class="dashboard-section">
            <h2>Lisää kategoria</h2>
            <form id="add-category-form">
                <input type="text" id="new-category" placeholder="Kategorian nimi" required>
                <button type="button" onclick="addCategory()">Lisää kategoria</button>
            </form>
        </section>

        <section class="dashboard-section">
            <h2>Olemassa olevat kategoriat</h2>
            <select id="existing-category-list" onchange="loadQuestions()">
                <option value="">Valitse kategoria</option>
                <!-- Kategoriat lisätään JavaScriptillä -->
            </select>
        </section>

        <section class="dashboard-section">
            <h2>Lisää kysymys</h2>
            <select id="question-category">
                <!-- Kategoriat lisätään JavaScriptillä -->
            </select>
            <input type="text" id="question-text" placeholder="Kysymys" required>
            <input type="text" id="option-a" placeholder="Vaihtoehto A" required>
            <input type="text" id="option-b" placeholder="Vaihtoehto B" required>
            <input type="text" id="option-c" placeholder="Vaihtoehto C" required>
            <input type="text" id="option-d" placeholder="Vaihtoehto D" required>
            <select id="correct-option">
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
            </select>
            <button onclick="addQuestion()">Lisää kysymys</button>
        </section>

        <section class="dashboard-section">
            <h2>Kysymykset valitussa kategoriassa</h2>
            <ul id="questions">
                <!-- Kysymykset lisätään JavaScriptillä -->
            </ul>
        </section>
    </div>

    <script src="teacher_dashboard.js"></script>
</body>
</html>
