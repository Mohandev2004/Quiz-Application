package com.controller;

import com.dao.UserDAO;
import com.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Basic validation
        if (user == null || user.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=Inputs cannot be empty.");
            return;
        }

        User newUser = new User(0, user, pass);
        if (userDAO.registerUser(newUser)) {
            response.sendRedirect("login.jsp?msg=Registration successful! Please login.");
        } else {
            response.sendRedirect("register.jsp?error=Username may already exist!");
        }
    }
}
