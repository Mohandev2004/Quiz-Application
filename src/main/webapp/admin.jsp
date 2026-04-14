<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.User, com.model.Question, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || session.getAttribute("isAdmin") == null || !(boolean)session.getAttribute("isAdmin")) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Question editQ = (Question) request.getAttribute("question");
    boolean isEdit = (editQ != null);
    List<Question> list = (List<Question>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Java Quiz App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Admin Control Panel</a>
        <div class="d-flex">
            <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4 px-4">
    <div class="row">

        <!-- Form Column -->
        <div class="col-lg-4 mb-4">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><%= isEdit ? "Edit Question" : "Add New Question" %></h5>
                </div>
                <div class="card-body">
                    <form action="AdminServlet" method="POST">
                        <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">
                        <% if(isEdit) { %>
                            <input type="hidden" name="id" value="<%= editQ.getId() %>">
                        <% } %>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Question Text</label>
                            <textarea name="question" required class="form-control" rows="3"><%= isEdit ? editQ.getQuestion() : "" %></textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Option 1</label>
                                <input type="text" name="option1" class="form-control" value="<%= isEdit ? editQ.getOption1() : "" %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Option 2</label>
                                <input type="text" name="option2" class="form-control" value="<%= isEdit ? editQ.getOption2() : "" %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Option 3</label>
                                <input type="text" name="option3" class="form-control" value="<%= isEdit ? editQ.getOption3() : "" %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Option 4</label>
                                <input type="text" name="option4" class="form-control" value="<%= isEdit ? editQ.getOption4() : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Exact Correct Answer</label>
                            <input type="text" name="correctAnswer" class="form-control" value="<%= isEdit ? editQ.getCorrectAnswer() : "" %>" required placeholder="Must match one of the options exactly">
                            <div class="form-text text-danger">Type the exact text of the correct option here.</div>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Question" : "Save Question" %></button>
                            <% if(isEdit) { %>
                                <a href="AdminServlet?action=list" class="btn btn-outline-secondary">Cancel</a>
                            <% } %>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Table Column -->
        <div class="col-lg-8">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Current Question Bank</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th style="width: 40%">Question</th>
                                    <th>Correct Answer</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (list != null && !list.isEmpty()) {
                                    for(Question q : list) { %>
                                    <tr>
                                        <td><%= q.getId() %></td>
                                        <td><%= q.getQuestion() %></td>
                                        <td><span class="badge bg-success"><%= q.getCorrectAnswer() %></span></td>
                                        <td class="text-end text-nowrap">
                                            <a href="AdminServlet?action=edit&id=<%= q.getId() %>" class="btn btn-sm btn-outline-primary">Edit</a>
                                            <a href="AdminServlet?action=delete&id=<%= q.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this question?');">Delete</a>
                                        </td>
                                    </tr>
                                <%  }
                                   } else { %>
                                    <tr><td colspan="4" class="text-center text-muted py-4">No questions available. Add some using the form.</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
