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
// Lataa kysymykset valitusta kategoriasta
async function loadQuestions() {
    const categoryId = document.getElementById('existing-category-list').value;

    if (!categoryId) {
        document.getElementById('questions').innerHTML = '';
        return;
    }

    try {
        const response = await fetch(`get_questions.php?category=${categoryId}&teacher_id=${teacherId}`);
        if (!response.ok) throw new Error("Kysymysten lataaminen epäonnistui");

        const questions = await response.json();

        const questionsContainer = document.getElementById('questions');
        questionsContainer.innerHTML = '';

        questions.forEach(question => {
            const questionItem = document.createElement('li');
            questionItem.classList.add('question-item');

            // Näytetään kysymyksen tiedot
            const questionText = document.createElement('div');
            questionText.classList.add('question-title');
            questionText.textContent = `${question.question} (A: ${question.option_a}, B: ${question.option_b}, C: ${question.option_c}, D: ${question.option_d}) - Oikea vastaus: ${question.correct_option}`;
            questionItem.appendChild(questionText);

            // Muokkaus-painike
            const editButton = document.createElement('button');
            editButton.textContent = 'Muokkaa';
            editButton.classList.add('edit-button');
            editButton.onclick = () => editQuestion(question);
            questionItem.appendChild(editButton);

            // Poisto-painike
            const deleteButton = document.createElement('button');
            deleteButton.textContent = 'Poista';
            deleteButton.classList.add('delete-button');
            deleteButton.onclick = () => deleteQuestion(question.id);
            questionItem.appendChild(deleteButton);

            questionsContainer.appendChild(questionItem);
        });
    } catch (error) {
        console.error("Virhe kysymysten latauksessa:", error);
        alert("Kysymysten lataaminen epäonnistui.");
    }
}



// Lisää kategoria
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

// Lisää uusi kysymys
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
        teacher_id: teacherId, // Lisätään opettajan ID
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
    } catch (error) {
        console.error("Virhe JSON-datan käsittelyssä:", error);
        alert("Yhteys palvelimeen epäonnistui.");
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

// Päivitä kysymys tietokantaan
async function updateQuestion(question) {
    try {
        const response = await fetch('update_question.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(question)
        });

        if (response.ok) {
            alert("Kysymys päivitetty onnistuneesti!");
            loadQuestions();
        } else {
            alert("Kysymyksen päivitys epäonnistui.");
        }
    } catch (error) {
        console.error("Virhe kysymyksen päivityksessä:", error);
    }
}

// Poista kysymys
async function deleteQuestion(questionId) {
    if (confirm("Haluatko varmasti poistaa kysymyksen?")) {
        try {
            const response = await fetch(`delete_question.php?id=${questionId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                alert("Kysymys poistettu!");
                loadQuestions();
            } else {
                alert("Kysymyksen poisto epäonnistui.");
            }
        } catch (error) {
            console.error("Virhe kysymyksen poistossa:", error);
        }
    }
}

loadCategories();
