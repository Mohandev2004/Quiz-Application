<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.model.User" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Active Quiz | QuizMaster</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Segoe UI',sans-serif;
    background:
    radial-gradient(circle at top right,#2563eb 0%,transparent 28%),
    radial-gradient(circle at bottom left,#06b6d4 0%,transparent 28%),
    #0f172a;
    color:white;
    min-height:100vh;
}

.hidden{
    display:none;
}

/* Navbar */
.navbar{
    background:rgba(2,6,23,.90);
    backdrop-filter:blur(12px);
    border-bottom:1px solid rgba(255,255,255,.05);
}

/* Timer */
.timer-box{
    font-size:1rem;
    font-weight:700;
    padding:10px 18px;
    border-radius:30px;
    background:#ef4444;
}

/* Card */
.quiz-card{
    background:rgba(255,255,255,.06);
    border:1px solid rgba(255,255,255,.08);
    border-radius:24px;
    backdrop-filter:blur(16px);
    box-shadow:0 25px 45px rgba(0,0,0,.22);
    overflow:hidden;
}

.quiz-header{
    background:rgba(255,255,255,.03);
    padding:20px 25px;
    border-bottom:1px solid rgba(255,255,255,.05);
}

.question-title{
    font-weight:700;
    font-size:1.2rem;
}

.question-badge{
    background:#1e293b;
    padding:10px 16px;
    border-radius:30px;
    font-weight:600;
}

/* Options */
.option-item{
    background:#111827;
    border:1px solid rgba(255,255,255,.06);
    color:white;
    border-radius:16px;
    padding:16px 18px;
    margin-bottom:14px;
    cursor:pointer;
    transition:.25s;
}

.option-item:hover{
    background:#1e293b;
    transform:translateY(-2px);
}

.option-item input{
    transform:scale(1.2);
    margin-right:12px;
}

/* Footer */
.quiz-footer{
    background:rgba(255,255,255,.03);
    padding:20px 25px;
    border-top:1px solid rgba(255,255,255,.05);
}

/* Buttons */
.btn-main{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    color:white;
    border-radius:12px;
    padding:10px 22px;
    font-weight:600;
}

.btn-main:hover{
    color:white;
    opacity:.95;
}

.btn-outline-custom{
    border:1px solid rgba(255,255,255,.15);
    color:white;
    border-radius:12px;
    padding:10px 22px;
}

.btn-outline-custom:hover{
    background:rgba(255,255,255,.08);
    color:white;
}
</style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark py-3">
<div class="container">

<span class="navbar-brand fw-bold">
<i class="bi bi-lightning-charge-fill me-2"></i>Quiz In Progress
</span>

<div class="timer-box" id="timerDisplay">--:--</div>

</div>
</nav>

<!-- Main -->
<div class="container py-5">

<div class="row justify-content-center">
<div class="col-lg-8">

<div class="quiz-card">

<!-- Header -->
<div class="quiz-header d-flex justify-content-between align-items-center">

<div class="question-title" id="questionHeader">
Loading...
</div>

<div class="question-badge" id="questionCountBadge">
0 / 0
</div>

</div>

<!-- Body -->
<div class="p-4">

<div id="loadingSpinner" class="text-center py-5">
<div class="spinner-border text-info mb-3"></div>
<p class="text-light">Loading quiz questions...</p>
</div>

<form id="quizForm" class="hidden">

<h3 class="mb-4" id="questionText"></h3>

<div id="optionsContainer"></div>

</form>

</div>

<!-- Footer -->
<div class="quiz-footer d-flex justify-content-between hidden"
id="quizFooter">

<button class="btn btn-outline-custom"
id="prevBtn" disabled>
Previous
</button>

<div>
<button class="btn btn-main hidden"
id="nextBtn">
Next
</button>

<button class="btn btn-success hidden ms-2"
id="submitBtn">
Submit Quiz
</button>
</div>

</div>

</div>

</div>
</div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function(){

let questions = [];
let currentIndex = 0;
let userAnswers = {};
let timerInterval;

const els = {
spinner: document.getElementById("loadingSpinner"),
form: document.getElementById("quizForm"),
footer: document.getElementById("quizFooter"),
qHeader: document.getElementById("questionHeader"),
qCountBadge: document.getElementById("questionCountBadge"),
qText: document.getElementById("questionText"),
optContainer: document.getElementById("optionsContainer"),
prevBtn: document.getElementById("prevBtn"),
nextBtn: document.getElementById("nextBtn"),
submitBtn: document.getElementById("submitBtn"),
timerDisplay: document.getElementById("timerDisplay")
};

/* Load Questions */
fetch("QuizServlet?action=getQuestions")
.then(res => res.json())
.then(data => {

questions = data;

if(questions.length > 0){
initQuiz();
}else{
els.spinner.innerHTML =
"<p class='text-danger'>No questions found.</p>";
}

})
.catch(err => console.log(err));

function initQuiz(){

els.spinner.classList.add("hidden");
els.form.classList.remove("hidden");
els.footer.classList.remove("hidden");

let timeRemaining = questions.length * 60;

updateTimer(timeRemaining);

timerInterval = setInterval(function(){

timeRemaining--;
updateTimer(timeRemaining);

if(timeRemaining <= 0){
clearInterval(timerInterval);
submitQuiz();
}

},1000);

renderQuestion();
}

function updateTimer(seconds){

if(seconds < 0) seconds = 0;

let m = Math.floor(seconds / 60);
let s = seconds % 60;

els.timerDisplay.innerText =
(m < 10 ? "0"+m : m) + ":" +
(s < 10 ? "0"+s : s);

if(seconds <= 30){
els.timerDisplay.style.background = "#f59e0b";
els.timerDisplay.style.color = "#111";
}

if(seconds <= 10){
els.timerDisplay.style.background = "#dc2626";
els.timerDisplay.style.color = "white";
}
}

function renderQuestion(){

let q = questions[currentIndex];

els.qHeader.innerText =
"Question " + (currentIndex + 1);

els.qCountBadge.innerText =
(currentIndex + 1) + " / " + questions.length;

els.qText.innerText = q.question;

let opts = [q.option1,q.option2,q.option3,q.option4];

let html = "";

opts.forEach(function(opt){

let checked =
(userAnswers[q.id] === opt) ? "checked" : "";

html += `
<label class="option-item d-block">
<input type="radio"
name="q_${q.id}"
value="${opt}"
${checked}
onchange="saveAnswer(${q.id}, this.value)">
${opt}
</label>
`;

});

els.optContainer.innerHTML = html;

els.prevBtn.disabled = currentIndex === 0;

if(currentIndex === questions.length - 1){
els.nextBtn.classList.add("hidden");
els.submitBtn.classList.remove("hidden");
}else{
els.nextBtn.classList.remove("hidden");
els.submitBtn.classList.add("hidden");
}
}

window.saveAnswer = function(id,val){
userAnswers[id] = val;
}

els.prevBtn.onclick = function(){
if(currentIndex > 0){
currentIndex--;
renderQuestion();
}
};

els.nextBtn.onclick = function(){
if(currentIndex < questions.length - 1){
currentIndex++;
renderQuestion();
}
};

els.submitBtn.onclick = function(){

if(confirm("Submit your quiz now?")){
submitQuiz();
}

};

function submitQuiz(){

clearInterval(timerInterval);

els.submitBtn.disabled = true;
els.submitBtn.innerText = "Submitting...";

let formData = new URLSearchParams();

for(let qId in userAnswers){
formData.append("q_" + qId, userAnswers[qId]);
}

fetch("QuizServlet",{
method:"POST",
body:formData
})
.then(res => res.text())
.then(data => {

window.onbeforeunload = null;
window.location.href = "ResultServlet";

})
.catch(err => {

alert("Submission failed.");
els.submitBtn.disabled = false;

});

}

/* Refresh Warning */
window.onbeforeunload = function(){
return "Leaving page may lose your progress.";
};

});
</script>

</body>
</html>