let questions = [];
let score = 0;
let currentQuestion = 0;
let teacherId = null;
let categoryId = null;
let questionCount = 10;
let inactivityTimer;

// Lataa opettajat heti sivun latautuessa
async function loadTeachers() {
    const response = await fetch('get_teachers.php');
    const teachers = await response.json();
    
    const teacherSelect = document.getElementById('teacher');
    teacherSelect.innerHTML = '<option value="">Valitse opettaja</option>';
    
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
        alert("Valitse ensin opettaja!");
        return;
    }

    const response = await fetch(`get_categories.php?teacher_id=${teacherId}`);
    const categories = await response.json();

    const categorySelect = document.getElementById('category');
    categorySelect.innerHTML = '<option value="">Valitse kategoria</option>';
    
    if (categories.length === 0) {
        alert("Tällä opettajalla ei ole kategorioita.");
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

// Aloita peli käyttäjän valitsemalla kysymysmäärällä
async function startQuiz() {
    categoryId = document.getElementById('category').value;
    questionCount = parseInt(document.getElementById('question-count').value);

    if (!categoryId) {
        alert("Valitse kategoria!");
        return;
    }

    const response = await fetch(`get_questions.php?category=${categoryId}&teacher_id=${teacherId}`);
    questions = await response.json();
    questions = questions.sort(() => 0.5 - Math.random()).slice(0, questionCount);
    score = 0;
    currentQuestion = 0;
    document.getElementById('category-select').style.display = 'none';
    document.getElementById('quiz').style.display = 'block';
    resetInactivityTimer();
    showQuestion();
}

// Näytä kysymys ja vastausvaihtoehdot
function showQuestion() {
    if (currentQuestion < questions.length) {
        resetInactivityTimer();
        const question = questions[currentQuestion];
        document.getElementById('question').textContent = question.question;
        document.getElementById('optionA').textContent = question.option_a;
        document.getElementById('optionB').textContent = question.option_b;
        document.getElementById('optionC').textContent = question.option_c;
        document.getElementById('optionD').textContent = question.option_d;

        // Nollataan mahdolliset aikaisemmat animoinnit
        ['A', 'B', 'C', 'D'].forEach(option => {
            const button = document.getElementById(`option${option}`);
            button.classList.remove('correct-answer');
        });
    } else {
        endQuiz();
    }
}

// Tarkista käyttäjän vastaus ja lisää animaatio
function checkAnswer(answer) {
    resetInactivityTimer();

    const question = questions[currentQuestion];
    const correctAnswer = question.correct_option;
    const selectedButton = document.getElementById(`option${answer}`);
    const correctButton = document.getElementById(`option${correctAnswer}`);

    if (answer === correctAnswer) {
        correctButton.classList.add('correct-answer');
        setTimeout(() => correctButton.classList.remove('correct-answer'), 1000); // Poista animaatio 1 sekunnin jälkeen
        score++;
    } else {
        correctButton.classList.add('correct-answer');
        setTimeout(() => correctButton.classList.remove('correct-answer'), 1000);
    }

    currentQuestion++;
    setTimeout(showQuestion, 1000); // Odota animaation ajan ennen seuraavaa kysymystä
}

// Lopeta peli ja näytä tulokset
function endQuiz() {
    clearTimeout(inactivityTimer);
    document.getElementById('quiz').style.display = 'none';
    const studentName = prompt("Anna nimesi tulostaulukkoon:");

    if (studentName) {
        saveScore(studentName);
    } else {
        alert("Nimi tarvitaan tuloksen tallentamiseen.");
    }
    document.getElementById('results').style.display = 'block';
    document.getElementById('final-score').textContent = `Pistemääräsi: ${score}/${questionCount}`;
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

// Näytä parhaat tulokset
async function showHighScores() {
    const response = await fetch('get_scores.php?category_id=' + categoryId);
    const scores = await response.json();
    const highScoresDiv = document.getElementById('high-scores');
    highScoresDiv.innerHTML = '<h3>Parhaat tulokset</h3>';
    
    scores.forEach(entry => {
        const p = document.createElement('p');
        p.textContent = `${entry.student_name} - Pisteet: ${entry.score}/${questionCount}`;
        highScoresDiv.appendChild(p);
    });
}

// Aloita uusi peli
function resetQuiz() {
    clearTimeout(inactivityTimer);
    document.getElementById('results').style.display = 'none';
    document.getElementById('teacher-select').style.display = 'block';
}

// Nollaa toimettomuusajastin
function resetInactivityTimer() {
    clearTimeout(inactivityTimer);
    inactivityTimer = setTimeout(() => {
        const continuePlaying = confirm("Haluatko pelata vielä?");
        if (continuePlaying) {
            resetQuiz();
        } else {
            alert("Kiitos pelaamisesta!");
        }
    }, 30000);
}

// Lataa opettajat heti sivun latautuessa
window.onload = loadTeachers;
