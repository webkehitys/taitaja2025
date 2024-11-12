// Lataa opettajan kategoriat ja täytä valintalista
async function loadCategories() {
    const response = await fetch('get_teacher_categories.php');
    const categories = await response.json();
    
    const categorySelect = document.getElementById('question-category');
    const existingCategoryList = document.getElementById('existing-category-list');
    categorySelect.innerHTML = '';
    existingCategoryList.innerHTML = '<option value="">Valitse kategoria</option>'; 

    categories.forEach(category => {
        const option = document.createElement('option');
        option.value = category.id;
        option.textContent = category.name;
        categorySelect.appendChild(option);

        const existingOption = option.cloneNode(true);
        existingCategoryList.appendChild(existingOption);
    });
}

// Lataa valitun kategorian kysymykset ja näytä ne listana
async function loadQuestions() {
    const categoryId = document.getElementById('existing-category-list').value;
    if (!categoryId) return;

    const response = await fetch(`get_teacher_questions.php?category_id=${categoryId}`);
    const questions = await response.json();
    
    const questionList = document.getElementById('questions');
    questionList.innerHTML = '';
    
    questions.forEach(question => {
        const listItem = document.createElement('li');
        listItem.textContent = `${question.question} (A: ${question.option_a}, B: ${question.option_b}, C: ${question.option_c}, D: ${question.option_d}) - Oikea vastaus: ${question.correct_option}`;
        questionList.appendChild(listItem);
    });
}

// Lisää uusi kategoria
async function addCategory() {
    const newCategory = document.getElementById('new-category').value.trim();
    if (newCategory) {
        await fetch('add_category.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: newCategory })
        });
        document.getElementById('new-category').value = '';
        loadCategories();
    }
}

// Lisää uusi kysymys valittuun kategoriaan
async function addQuestion() {
    const category_id = document.getElementById('question-category').value;
    const question = document.getElementById('question-text').value;
    const optionA = document.getElementById('option-a').value;
    const optionB = document.getElementById('option-b').value;
    const optionC = document.getElementById('option-c').value;
    const optionD = document.getElementById('option-d').value;
    const correctOption = document.getElementById('correct-option').value;

    if (question && optionA && optionB && optionC && optionD) {
        await fetch('add_question.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                category_id: category_id,
                question: question,
                option_a: optionA,
                option_b: optionB,
                option_c: optionC,
                option_d: optionD,
                correct_option: correctOption
            })
        });
        loadQuestions(); // Päivitä kysymyslista
    }
}

// Lataa kategoriat heti sivun latautuessa
loadCategories();
