package com.controller;

import com.dao.ResultDAO;
import com.model.Result;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {
    private ResultDAO resultDAO;

    @Override
    public void init() {
        resultDAO = new ResultDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Result> results = resultDAO.getResultsByUsername(user.getUsername());
        
        request.setAttribute("history", results);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
