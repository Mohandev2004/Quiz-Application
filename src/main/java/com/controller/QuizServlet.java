package com.controller;

import com.dao.QuestionDAO;
import com.dao.ResultDAO;
import com.model.Question;
import com.model.Result;
import com.model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {

    private QuestionDAO questionDAO;
    private ResultDAO resultDAO;

    @Override
    public void init() {
        questionDAO = new QuestionDAO();
        resultDAO = new ResultDAO();
    }

    // ===================== GET =====================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔒 Session protection
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        String action = request.getParameter("action");

        // ===================== START QUIZ =====================
        if ("start".equals(action)) {

            List<Question> questions = questionDAO.getAllQuestions();

            if (questions.isEmpty()) {
                request.setAttribute("error", "No questions available.");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                return;
            }

            // Save questions in session
            session.setAttribute("quizQuestions", questions);

            // Redirect to quiz page
            response.sendRedirect("quiz.jsp");
        }

        // ===================== GET QUESTIONS (AJAX) =====================
        else if ("getQuestions".equals(action)) {

            List<Question> questions = (List<Question>) session.getAttribute("quizQuestions");

            // If session expired or not started
            if (questions == null) {
                questions = List.of(); // empty list
            }

            // Convert to JSON using Gson
            Gson gson = new Gson();
            String json = gson.toJson(questions);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            response.getWriter().print(json);
        }
    }

    // ===================== POST (SUBMIT QUIZ) =====================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        List<Question> questions = (List<Question>) session.getAttribute("quizQuestions");

        if (questions == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No active quiz");
            return;
        }

        int score = 0;
        int totalQuestions = questions.size();
        
        // Use a simple list of maps for feedback, then convert to JSON with Gson
        java.util.List<java.util.Map<String, Object>> feedbackList = new java.util.ArrayList<>();

        for (Question q : questions) {
            String userAnswer = request.getParameter("q_" + q.getId());
            boolean isCorrect = userAnswer != null && userAnswer.equals(q.getCorrectAnswer());
            
            if (isCorrect) score++;

            java.util.Map<String, Object> map = new java.util.HashMap<>();
            map.put("question", q.getQuestion());
            map.put("userAnswer", userAnswer != null ? userAnswer : "Not Answered");
            map.put("correctAnswer", q.getCorrectAnswer());
            map.put("isCorrect", isCorrect);
            feedbackList.add(map);
        }

        User user = (User) session.getAttribute("user");
        Result result = new Result(0, user.getUsername(), score, totalQuestions, null);
        
        boolean saved = resultDAO.saveResult(result);
        System.out.println("Quiz submitted by " + user.getUsername() + ". Score: " + score + "/" + totalQuestions + ". Saved: " + saved);

        // Store result in session
        session.setAttribute("lastScore", score);
        session.setAttribute("totalQuestions", totalQuestions);
        session.setAttribute("lastFeedback", new Gson().toJson(feedbackList));
        
        // Clear quiz session
        session.removeAttribute("quizQuestions"); 

        // AJAX response
        response.setContentType("text/plain");
        response.getWriter().write("success");
    }
}