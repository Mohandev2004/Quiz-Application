document.addEventListener("DOMContentLoaded", function() {
    // totalTimerSeconds should be defined globally by JSP before this script is loaded.
    if (typeof totalTimerSeconds === 'undefined') {
        console.error("Timer seconds not defined.");
        return;
    }

    let timeRemaining = totalTimerSeconds;
    const timeDisplay = document.getElementById("time-left");
    const quizForm = document.getElementById("quiz-form");

    function formatTime(seconds) {
        const m = Math.floor(seconds / 60);
        const s = seconds % 60;
        return (m < 10 ? "0" + m : m) + ":" + (s < 10 ? "0" + s : s);
    }

    function updateDisplay() {
        timeDisplay.innerText = formatTime(timeRemaining);
        if (timeRemaining <= 30) {
            // Add pulse effect when time is running out
            timeDisplay.parentElement.style.animation = "pulse 1s infinite alternate";
            timeDisplay.parentElement.style.background = "#991B1B"; // Darker red
        }
    }

    // Initialize display
    updateDisplay();

    // Start countdown
    const timerInterval = setInterval(function() {
        timeRemaining--;
        updateDisplay();

        if (timeRemaining <= 0) {
            clearInterval(timerInterval);
            timeDisplay.innerText = "00:00";
            alert("Time is up! Submitting your answers automatically.");
            quizForm.submit();
        }
    }, 1000);

    // Prompt user on refresh/close but only if they haven't submitted
    let isSubmitting = false;
    
    quizForm.addEventListener('submit', function() {
        isSubmitting = true;
    });

    window.addEventListener('beforeunload', function(e) {
        if (!isSubmitting) {
            e.preventDefault();
            e.returnValue = ''; // Required for Chrome/Firefox warning
        }
    });

    // Handle pulse animation in CSS if not already there
    const style = document.createElement("style");
    style.innerHTML = `
        @keyframes pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.05); }
        }
    `;
    document.head.appendChild(style);
});
