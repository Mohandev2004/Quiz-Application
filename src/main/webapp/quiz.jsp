<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
    <%@ page import="com.model.User" %>
        <% User user=(User) session.getAttribute("user"); if(user==null) { response.sendRedirect("login.jsp"); return; }
            %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Active Quiz - Java Quiz App</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    .timer-badge {
                        font-size: 1.25rem;
                    }

                    .hidden {
                        display: none;
                    }
                </style>
            </head>

            <body class="bg-light">

                <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                    <div class="container">
                        <span class="navbar-brand">Quiz in Progress</span>
                        <div class="d-flex align-items-center">
                            <span class="badge bg-danger timer-badge" id="timerDisplay">--:--</span>
                        </div>
                    </div>
                </nav>

                <div class="container mt-5" id="quizContainer">

                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="card shadow-sm">

                                <div
                                    class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                    <h5 class="mb-0" id="questionHeader">Loading...</h5>
                                    <span class="badge bg-secondary" id="questionCountBadge">0 / 0</span>
                                </div>

                                <div class="card-body p-4">
                                    <div id="loadingSpinner" class="text-center py-5">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                        <p class="mt-2 text-muted">Fetching questions...</p>
                                    </div>

                                    <form id="quizForm" class="hidden">
                                        <h4 id="questionText" class="mb-4"></h4>

                                        <div class="list-group mb-4" id="optionsContainer">
                                            <!-- Options injected dynamically via JS -->
                                        </div>
                                    </form>
                                </div>

                                <div class="card-footer bg-white d-flex justify-content-between py-3 hidden"
                                    id="quizFooter">
                                    <button class="btn btn-outline-secondary" id="prevBtn" disabled>Previous</button>
                                    <div>
                                        <button class="btn btn-primary hidden" id="nextBtn">Next</button>
                                        <button class="btn btn-success hidden" id="submitBtn">Submit Quiz</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- AJAX and Quiz Logic -->
                <script>
                    document.addEventListener("DOMContentLoaded", function () {

                        let questions = [];
                        let currentIndex = 0;
                        let userAnswers = {};
                        let timerInterval;

                        const els = {
                            spinner: document.getElementById('loadingSpinner'),
                            form: document.getElementById('quizForm'),
                            footer: document.getElementById('quizFooter'),
                            qHeader: document.getElementById('questionHeader'),
                            qCountBadge: document.getElementById('questionCountBadge'),
                            qText: document.getElementById('questionText'),
                            optContainer: document.getElementById('optionsContainer'),
                            prevBtn: document.getElementById('prevBtn'),
                            nextBtn: document.getElementById('nextBtn'),
                            submitBtn: document.getElementById('submitBtn'),
                            timerDisplay: document.getElementById('timerDisplay')
                        };

                        // 1. Fetch Questions via AJAX
                        fetch('QuizServlet?action=getQuestions')
                            .then(res => res.json())
                            .then(data => {
                                questions = data;
                                if (questions.length > 0) {
                                    initQuiz();
                                } else {
                                    els.qHeader.innerText = "Error";
                                    els.spinner.innerHTML = "<p class='text-danger'>No questions found. Contact Admin.</p>";
                                }
                            })
                            .catch(err => console.error(err));

                        function initQuiz() {
                            // Initialize UI
                            els.spinner.classList.add('hidden');
                            els.form.classList.remove('hidden');
                            els.footer.classList.remove('hidden');

                            // Timer Logic (1 min per question)
                            let timeRemaining = questions.length * 60;
                            updateTimerDisplay(timeRemaining);

                            timerInterval = setInterval(() => {
                                timeRemaining--;
                                updateTimerDisplay(timeRemaining);
                                if (timeRemaining <= 0) {
                                    clearInterval(timerInterval);
                                    submitQuiz();
                                }
                            }, 1000);

                            renderQuestion();
                        }

                        function updateTimerDisplay(seconds) {
                            if (seconds <= 0) seconds = 0;
                            let m = Math.floor(seconds / 60);
                            let s = seconds % 60;
                            els.timerDisplay.innerText = (m < 10 ? '0' + m : m) + ':' + (s < 10 ? '0' + s : s);
                            if (seconds <= 30) {
                                els.timerDisplay.classList.remove('bg-danger');
                                els.timerDisplay.classList.add('bg-warning', 'text-dark');
                            }
                        }

                        function renderQuestion() {
                            const q = questions[currentIndex];

                            els.qHeader.innerText = "Question " + (currentIndex + 1);
                            els.qCountBadge.innerText = (currentIndex + 1) + " / " + questions.length;
                            els.qText.innerText = q.question;

                            // Dynamically create options
                            const opts = [q.option1, q.option2, q.option3, q.option4];
                            let html = '';
                            opts.forEach((opt, i) => {
                                let checked = (userAnswers[q.id] === opt) ? 'checked' : '';
                                html += '<label class="list-group-item list-group-item-action text-dark fs-5 py-3">' +
                                        '<input class="form-check-input me-3 border-secondary" type="radio" name="q_' + q.id + '" value="' + opt + '" ' + checked + ' onchange="saveAnswer(' + q.id + ', this.value)">' +
                                        opt +
                                        '</label>';
                            });
                            els.optContainer.innerHTML = html;

                            // Button states
                            els.prevBtn.disabled = (currentIndex === 0);

                            if (currentIndex === questions.length - 1) {
                                els.nextBtn.classList.add('hidden');
                                els.submitBtn.classList.remove('hidden');
                            } else {
                                els.nextBtn.classList.remove('hidden');
                                els.submitBtn.classList.add('hidden');
                            }
                        }

                        window.saveAnswer = function (qId, val) {
                            userAnswers[qId] = val;
                        }

                        els.prevBtn.addEventListener('click', () => {
                            if (currentIndex > 0) { currentIndex--; renderQuestion(); }
                        });

                        els.nextBtn.addEventListener('click', () => {
                            if (currentIndex < questions.length - 1) { currentIndex++; renderQuestion(); }
                        });

                        els.submitBtn.addEventListener('click', () => {
                            if (confirm("Are you sure you want to finish the quiz?")) {
                                submitQuiz();
                            }
                        });

                        // Submits the form data via AJAX POST
                        function submitQuiz() {
                            clearInterval(timerInterval);
                            els.submitBtn.disabled = true;
                            els.submitBtn.innerText = "Evaluating...";

                            // Form URL Encoded data
                            let formData = new URLSearchParams();
                            for (let qId in userAnswers) {
                                formData.append('q_' + qId, userAnswers[qId]);
                            }

                            fetch('QuizServlet', {
                                method: 'POST',
                                body: formData
                            })
                                .then(res => res.text())
                                .then(result => {
                                    // Once saved logic evaluates on server, redirect to result screen
                                    window.onbeforeunload = null; // Remove refresh block
                                    window.location.href = "ResultServlet";
                                })
                                .catch(err => {
                                    alert("Error submitting quiz!");
                                    els.submitBtn.disabled = false;
                                });
                        }

                        // Prevent page refresh warning
                        window.onbeforeunload = function () {
                            return "Leaving this page will lose your quiz progress.";
                        };
                    });
                </script>

            </body>

            </html>