let questions = [];
let score = 0;
let currentQuestion = 0;
let teacherId = null;
let categoryId = null;

// Hae opettajat ja aseta valintaikkunaan
async function loadTeachers() {
    const response = await fetch('get_teachers.php');
    const teachers = await response.json();
    const teacherSelect = document.getElementById('teacher');
    teacherSelect.innerHTML = '';
    teachers.forEach(teacher => {
        const option = document.createElement('option');
        option.value = teacher.id;
        option.textContent = teacher.username;
        teacherSelect.appendChild(option);
    });
}

// Hae valitun opettajan kategoriat
async function loadCategories() {
    teacherId = document.getElementById('teacher').value;
    
    if (!teacherId) {
        console.error("Opettajaa ei valittu.");
        return;
    }

    const response = await fetch(`get_categories.php?teacher_id=${teacherId}`);
    const categories = await response.json();
    
    const categorySelect = document.getElementById('category');
    categorySelect.innerHTML = ''; // Tyhjennä kategoriavalinta
    
    if (categories.length === 0) {
        console.log("Ei kategorioita tälle opettajalle.");
        categorySelect.innerHTML = '<option disabled>Ei kategorioita</option>';
        return;
    }

    categories.forEach(category => {
        const option = document.createElement('option');
        option.value = category.id;
        option.textContent = category.name;
        categorySelect.appendChild(option);
    });
    
    document.getElementById('teacher-select').style.display = 'none';
    document.getElementById('category-select').style.display = 'block';
}

// Aloita peli valitun kategorian kysymyksillä
async function startQuiz() {
    categoryId = document.getElementById('category').value;
    const response = await fetch(`get_questions.php?category=${categoryId}&teacher_id=${teacherId}`);
    questions = await response.json();
    questions = questions.sort(() => 0.5 - Math.random()).slice(0, 10); // Arvo 10 kysymystä
    score = 0;
    currentQuestion = 0;
    document.getElementById('category-select').style.display = 'none';
    document.getElementById('quiz').style.display = 'block';
    showQuestion();
}

// Näytä kysymys ja vaihtoehdot
function showQuestion() {
    if (currentQuestion < questions.length) {
        const question = questions[currentQuestion];
        document.getElementById('question').textContent = question.question;
        document.getElementById('optionA').textContent = question.option_a;
        document.getElementById('optionB').textContent = question.option_b;
        document.getElementById('optionC').textContent = question.option_c;
        document.getElementById('optionD').textContent = question.option_d;
    } else {
        endQuiz();
    }
}

// Tarkista käyttäjän vastaus
function checkAnswer(answer) {
    if (answer === questions[currentQuestion].correct_option) {
        score++;
    }
    currentQuestion++;
    showQuestion();
}

// Lopeta peli ja kysy käyttäjän nimi tuloksen tallentamiseksi
function endQuiz() {
    document.getElementById('quiz').style.display = 'none';
    const studentName = prompt("Anna nimesi tulostaulukkoon:");
    
    if (studentName) {
        saveScore(studentName);
    } else {
        alert("Nimi tarvitaan tuloksen tallentamiseen.");
        document.getElementById('results').style.display = 'block';
        document.getElementById('final-score').textContent = `Pistemääräsi: ${score}/10`;
    }
}

// Tallentaa käyttäjän tuloksen tietokantaan
async function saveScore(studentName) {
    await fetch('save_score.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ student_name: studentName, score: score, category_id: categoryId })
    });
    showHighScores();
}

// Hae parhaat tulokset ja näytä ne
async function showHighScores() {
    const response = await fetch('get_scores.php?category_id=' + categoryId);
    const scores = await response.json();
    const highScoresDiv = document.getElementById('high-scores');
    highScoresDiv.innerHTML = '<h3>Parhaat tulokset</h3>';
    
    scores.forEach(entry => {
        const p = document.createElement('p');
        p.textContent = `${entry.student_name} ${entry.score}/10 - ${entry.category_name} - ${entry.teacher_name}`;
        highScoresDiv.appendChild(p);
    });

    document.getElementById('results').style.display = 'block';
    document.getElementById('final-score').textContent = `Pistemääräsi: ${score}/10`;
}





// Aloita uusi peli
function resetQuiz() {
    document.getElementById('results').style.display = 'none';
    document.getElementById('teacher-select').style.display = 'block';
}

// Lataa opettajat heti sivun latautuessa
loadTeachers();
