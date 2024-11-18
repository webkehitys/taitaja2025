// Lataa kategoriat opettajalle
async function loadCategories() {
    try {
        const response = await fetch(`get_categories.php?teacher_id=${teacherId}`);
        if (!response.ok) throw new Error("Kategorioiden lataaminen epäonnistui");
        
        const categories = await response.json();

        const existingCategoryList = document.getElementById('existing-category-list');
        const questionCategorySelect = document.getElementById('question-category');

        // Tyhjennä vanhat kategoriat valikoista
        existingCategoryList.innerHTML = '<option value="">Valitse kategoria</option>';
        questionCategorySelect.innerHTML = '';

        categories.forEach(category => {
            const option = document.createElement('option');
            option.value = category.id;
            option.textContent = category.name;
            existingCategoryList.appendChild(option);

            // Lisätään sama kategoria myös kysymyksen lisäysvalikkoon
            const optionClone = option.cloneNode(true);
            questionCategorySelect.appendChild(optionClone);
        });
    } catch (error) {
        console.error("Virhe kategoriat ladattaessa:", error);
    }
}

// Lataa kysymykset valitusta kategoriasta ja lisää muokkaus- ja poistopainikkeet
async function loadQuestions() {
    const categoryId = document.getElementById('existing-category-list').value;

    if (!categoryId) return;

    const response = await fetch(`get_questions.php?category=${categoryId}&teacher_id=${teacherId}`);
    const questions = await response.json();

    const questionsContainer = document.getElementById('questions');
    questionsContainer.innerHTML = '';

    questions.forEach(question => {
        const questionItem = document.createElement('li');
        questionItem.classList.add('question-item');

        // Kysymyksen teksti
        const questionTitle = document.createElement('div');
        questionTitle.classList.add('question-title');
        questionTitle.textContent = `${question.question} (A: ${question.option_a}, B: ${question.option_b}, C: ${question.option_c}, D: ${question.option_d}) - Oikea vastaus: ${question.correct_option}`;

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

        // Lisää kysymys ja painikkeet
        questionItem.appendChild(questionTitle);
        questionItem.appendChild(editButton);
        questionItem.appendChild(deleteButton);
        questionsContainer.appendChild(questionItem);
    });
}

// Lisää uusi kategoria
async function addCategory() {
    const categoryName = document.getElementById('new-category').value;

    if (categoryName) {
        await fetch('add_category.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ teacher_id: teacherId, name: categoryName })
        });
        document.getElementById('new-category').value = '';
        loadCategories();
    } else {
        alert("Anna kategorian nimi.");
    }
}

// Muokkaa kysymystä
function editQuestion(question) {
    const newQuestionText = prompt("Muokkaa kysymystä:", question.question);
    if (newQuestionText) {
        question.question = newQuestionText;
        updateQuestion(question);
    }
}

// Päivitä kysymys tietokannassa
async function updateQuestion(question) {
    await fetch('update_question.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(question)
    });
    loadQuestions();
}

// Poista kysymys
async function deleteQuestion(questionId) {
    if (confirm("Haluatko varmasti poistaa kysymyksen?")) {
        await fetch(`delete_question.php?id=${questionId}`, {
            method: 'DELETE'
        });
        loadQuestions();
    }
}

// Lataa kategoriat heti sivun latautuessa
window.onload = loadCategories;
