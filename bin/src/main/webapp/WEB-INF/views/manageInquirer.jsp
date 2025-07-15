<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.PlotInquirer" %>
<html>
<head>
    <title>Manage Plot Inquirer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h2 class="mb-4">Manage Plot Inquirers</h2>

<%-- Show flash messages --%>
<%
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<% if (successMessage != null) { %>
    <div class="alert alert-success"><%= successMessage %></div>
<% } %>

<% if (errorMessage != null) { %>
    <div class="alert alert-danger"><%= errorMessage %></div>
<% } %>

<form method="post" action="inquirer/add" class="mb-4">
    <div class="mb-3">
        <input type="text" name="name" placeholder="Name" class="form-control" required>
    </div>
    <div class="mb-3">
        <input type="text" name="phone" placeholder="Phone" maxlength="10" class="form-control" required>
    </div>
    <div class="mb-3">
        <textarea name="address" placeholder="Address" class="form-control" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Add Inquirer</button>
</form>

  
</body>
</html>
