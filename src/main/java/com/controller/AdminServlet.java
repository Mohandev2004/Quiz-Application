package com.controller;

import com.dao.QuestionDAO;
import com.model.Question;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private QuestionDAO questionDAO;

    @Override
    public void init() {
        questionDAO = new QuestionDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isAdmin") == null || !(boolean)session.getAttribute("isAdmin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "delete":
                    deleteQuestion(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "list":
                default:
                    listQuestions(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isAdmin") == null || !(boolean)session.getAttribute("isAdmin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                addQuestion(request, response);
            } else if ("update".equals(action)) {
                updateQuestion(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listQuestions(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("questions", questionDAO.getAllQuestions());
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Question existingQuestion = questionDAO.getQuestionById(id);
        request.setAttribute("question", existingQuestion);
        request.setAttribute("questions", questionDAO.getAllQuestions()); 
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    private void addQuestion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String qText = request.getParameter("question");
        String option1 = request.getParameter("option1");
        String option2 = request.getParameter("option2");
        String option3 = request.getParameter("option3");
        String option4 = request.getParameter("option4");
        String correctAnswer = request.getParameter("correctAnswer");

        Question newQuestion = new Question(0, qText, option1, option2, option3, option4, correctAnswer);
        questionDAO.addQuestion(newQuestion);
        response.sendRedirect("AdminServlet?action=list");
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String qText = request.getParameter("question");
        String option1 = request.getParameter("option1");
        String option2 = request.getParameter("option2");
        String option3 = request.getParameter("option3");
        String option4 = request.getParameter("option4");
        String correctAnswer = request.getParameter("correctAnswer");

        Question question = new Question(id, qText, option1, option2, option3, option4, correctAnswer);
        questionDAO.updateQuestion(question);
        response.sendRedirect("AdminServlet?action=list");
    }

    private void deleteQuestion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        questionDAO.deleteQuestion(id);
        response.sendRedirect("AdminServlet?action=list");
    }
}
