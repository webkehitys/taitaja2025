<?php
session_start();
include 'db.php';

// Tarkista kirjautuminen
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Opettajan Hallintapaneeli</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="dashboard-container">
        <h1>Tervetuloa, <?php echo $_SESSION['username']; ?></h1>

        <!-- Lisää kategoria -->
        <section class="dashboard-section">
            <h2>Lisää Kategoria</h2>
            <form id="add-category-form">
                <input type="text" id="new-category" placeholder="Kategorian nimi" required>
                <button type="button" onclick="addCategory()">Lisää kategoria</button>
            </form>
        </section>

        <!-- Olemassa olevat kategoriat -->
        <section class="dashboard-section">
            <h2>Olemassa Olevat Kategoriat</h2>
            <select id="existing-category-list" onchange="loadQuestions()">
                <option value="">Valitse kategoria</option>
            </select>
        </section>

        <!-- Lisää kysymys -->
        <section class="dashboard-section">
            <h2>Lisää Kysymys</h2>
            <select id="question-category"></select>
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

        <!-- Kysymysten lista -->
        <section class="dashboard-section">
            <h2>Kysymykset Valitussa Kategoriassa</h2>
            <ul id="questions"></ul>
        </section>
    </div>

    <script>
        let teacherId = <?php echo $teacher_id; ?>;

        // Lataa kategoriat
        async function loadCategories() {
            const response = await fetch(`get_categories.php?teacher_id=${teacherId}`);
            const categories = await response.json();

            const existingCategoryList = document.getElementById('existing-category-list');
            const questionCategorySelect = document.getElementById('question-category');

            existingCategoryList.innerHTML = '<option value="">Valitse kategoria</option>';
            questionCategorySelect.innerHTML = '';

            categories.forEach(category => {
                const option = document.createElement('option');
                option.value = category.id;
                option.textContent = category.name;
                existingCategoryList.appendChild(option);

                const optionClone = option.cloneNode(true);
                questionCategorySelect.appendChild(optionClone);
            });
        }

        // Lisää kategoria
        async function addCategory() {
            const categoryName = document.getElementById('new-category').value;

            if (!categoryName) {
                alert("Anna kategorian nimi!");
                return;
            }

            const response = await fetch('add_category.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ teacher_id: teacherId, name: categoryName })
            });

            if (response.ok) {
                document.getElementById('new-category').value = '';
                loadCategories();
            } else {
                alert("Kategorian lisääminen epäonnistui.");
            }
        }

        // Lataa kysymykset
        async function loadQuestions() {
            const categoryId = document.getElementById('existing-category-list').value;

            if (!categoryId) {
                document.getElementById('questions').innerHTML = '';
                return;
            }

            const response = await fetch(`get_questions.php?category=${categoryId}&teacher_id=${teacherId}`);
            const questions = await response.json();

            const questionsContainer = document.getElementById('questions');
            questionsContainer.innerHTML = '';

            questions.forEach(question => {
                const listItem = document.createElement('li');
                listItem.classList.add('question-item');

                // Kysymyksen teksti
                const questionTitle = document.createElement('div');
                questionTitle.classList.add('question-title');
                questionTitle.textContent = `${question.question} (Oikea vastaus: ${question.correct_option})`;

                // Muokkaus-painike
                const editButton = document.createElement('button');
                editButton.textContent = 'Muokkaa';
                editButton.classList.add('edit-button');
                editButton.onclick = () => editQuestion(question);

                // Poisto-painike
                const deleteButton = document.createElement('button');
                deleteButton.textContent = 'Poista';
                deleteButton.classList.add('delete-button');
                deleteButton.onclick = () => deleteQuestion(question.id);

                listItem.appendChild(questionTitle);
                listItem.appendChild(editButton);
                listItem.appendChild(deleteButton);
                questionsContainer.appendChild(listItem);
            });
        }

        // Poista kysymys
        async function deleteQuestion(questionId) {
            if (confirm("Haluatko varmasti poistaa kysymyksen?")) {
                await fetch(`delete_question.php?id=${questionId}`, { method: 'DELETE' });
                loadQuestions();
            }
        }

        // Muokkaa kysymystä
        async function editQuestion(question) {
            const newText = prompt("Muokkaa kysymystä:", question.question);
            if (!newText) return;

            question.question = newText;

            await fetch('update_question.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(question),
            });

            loadQuestions();
        }

       // Lisää kysymys
async function addQuestion() {
    const categorySelect = document.getElementById('question-category');
    const questionText = document.getElementById('question-text').value.trim();
    const optionA = document.getElementById('option-a').value.trim();
    const optionB = document.getElementById('option-b').value.trim();
    const optionC = document.getElementById('option-c').value.trim();
    const optionD = document.getElementById('option-d').value.trim();
    const correctOption = document.getElementById('correct-option').value;
    const categoryId = categorySelect.value;

    // Tarkistetaan, että kaikki kentät on täytetty
    if (!categoryId || !questionText || !optionA || !optionB || !optionC || !optionD || !correctOption) {
        alert("Täytä kaikki kentät!");
        return;
    }

    const data = {
        category_id: categoryId,
        question: questionText,
        option_a: optionA,
        option_b: optionB,
        option_c: optionC,
        option_d: optionD,
        correct_option: correctOption
    };

    try {
        const response = await fetch('add_question.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });

        const result = await response.json();

        if (result.success) {
            alert("Kysymys lisätty onnistuneesti!");
            // Tyhjennä lomakekentät
            document.getElementById('question-text').value = '';
            document.getElementById('option-a').value = '';
            document.getElementById('option-b').value = '';
            document.getElementById('option-c').value = '';
            document.getElementById('option-d').value = '';
            document.getElementById('correct-option').value = 'A';
            loadQuestions(); // Päivitetään kysymyslista
        } else {
            alert("Kysymyksen lisääminen epäonnistui: " + (result.error || "Tuntematon virhe"));
        }
    } catch (error) {
        console.error("Virhe kysymyksen lisäyksessä:", error);
        alert("Virhe yhteydessä palvelimeen. Tarkista konsoli lisätietoja varten.");
    }
}
 

        // Lataa kategoriat heti sivun latautuessa
        window.onload = loadCategories;
    </script>
</body>
</html>
