package com.controller;

import com.dao.UserDAO;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Hardcoded admin check
        if ("admin".equals(user) && "admin123".equals(pass)) {
            HttpSession session = request.getSession();
            User adminUser = new User(0, "admin", "admin123");
            session.setAttribute("user", adminUser);
            session.setAttribute("isAdmin", true);
            response.sendRedirect("admin.jsp");
            return;
        }

        User authenticatedUser = userDAO.authenticate(user, pass);

        if (authenticatedUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", authenticatedUser);
            session.setAttribute("isAdmin", false);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=Invalid username or password.");
        }
    }
}
