let teacherId = null;

// Lataa kategoriat ja näytä ne valintalistassa
async function loadCategories() {
    const teacherId = <?php echo $teacher_id; ?>; // Haetaan opettajan ID PHP:stä
    const response = await fetch(`get_categories.php?teacher_id=${teacherId}`);
    const categories = await response.json();

    const existingCategoryList = document.getElementById('existing-category-list');
    const questionCategorySelect = document.getElementById('question-category');

    existingCategoryList.innerHTML = '<option value="">Valitse kategoria</option>';
    questionCategorySelect.innerHTML = '<option value="">Valitse kategoria</option>';

    if (categories.length === 0) {
        alert("Ei kategorioita tällä opettajalla.");
        return;
    }

    categories.forEach(category => {
        const option1 = document.createElement('option');
        option1.value = category.id;
        option1.textContent = category.name;
        existingCategoryList.appendChild(option1);

        const option2 = document.createElement('option');
        option2.value = category.id;
        option2.textContent = category.name;
        questionCategorySelect.appendChild(option2);
    });
}


// Lataa kysymykset valitussa kategoriassa
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
        correct_option: correctOption,
        teacher_id: teacherId
    };

    const response = await fetch('add_question.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });

    const result = await response.json();

    if (result.success) {
        alert("Kysymys lisätty onnistuneesti!");
        document.getElementById('question-text').value = '';
        document.getElementById('option-a').value = '';
        document.getElementById('option-b').value = '';
        document.getElementById('option-c').value = '';
        document.getElementById('option-d').value = '';
        document.getElementById('correct-option').value = 'A';
        loadQuestions();
    } else {
        alert("Kysymyksen lisääminen epäonnistui: " + (result.error || "Tuntematon virhe"));
    }
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

// Lataa kategoriat ja opettajan tiedot sivun latauksessa
window.onload = loadCategories;
