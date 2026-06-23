// Quiz Widget for Support Chatbot Architecture Lessons
class Quiz {
    constructor(container, questions) {
        this.container = container;
        this.questions = questions;
        this.currentQuestion = 0;
        this.score = 0;
        this.init();
    }
    
    init() {
        this.container.innerHTML = '';
        this.showQuestion();
    }
    
    showQuestion() {
        if (this.currentQuestion >= this.questions.length) {
            this.showResults();
            return;
        }
        
        const question = this.questions[this.currentQuestion];
        const questionHTML = '<div class="quiz-question">' +
            '<h3>Question ' + (this.currentQuestion + 1) + ' of ' + this.questions.length + '</h3>' +
            '<p><strong>' + question.question + '</strong></p>' +
            '<div class="quiz-options">' +
            question.options.map(function(option, index) {
                return '<label class="quiz-option">' +
                    '<input type="radio" name="question' + this.currentQuestion + '" value="' + index + '">' +
                    option +
                    '</label>';
            }.bind(this)).join('') +
            '</div>' +
            '<button class="quiz-submit" onclick="quiz.checkAnswer()">Check Answer</button>' +
            '<div class="quiz-feedback" id="feedback"></div>' +
            '</div>';
        
        this.container.innerHTML = questionHTML;
    }
    
    checkAnswer() {
        var selected = document.querySelector('input[name="question' + this.currentQuestion + '"]:checked');
        if (!selected) {
            document.getElementById('feedback').innerHTML = '<p style="color: #f59e0b;">Please select an answer.</p>';
            return;
        }
        
        var answer = parseInt(selected.value);
        var question = this.questions[this.currentQuestion];
        var isCorrect = answer === question.correct;
        
        if (isCorrect) {
            this.score++;
            document.getElementById('feedback').innerHTML = '<p style="color: #10b981;">Correct! ' + question.explanation + '</p>';
        } else {
            document.getElementById('feedback').innerHTML = '<p style="color: #ef4444;">Incorrect. ' + question.explanation + '</p>';
        }
        
        var self = this;
        setTimeout(function() {
            self.currentQuestion++;
            self.showQuestion();
        }, 3000);
    }
    
    showResults() {
        var percentage = Math.round((this.score / this.questions.length) * 100);
        var message = percentage >= 80 ? 
            '<p style="color: #10b981;">Great job! You understand the concepts well.</p>' :
            '<p style="color: #f59e0b;">Review the lesson material and try again.</p>';
        
        this.container.innerHTML = '<div class="quiz-results">' +
            '<h3>Quiz Complete!</h3>' +
            '<p>Score: ' + this.score + '/' + this.questions.length + ' (' + percentage + '%)</p>' +
            message +
            '</div>';
    }
}