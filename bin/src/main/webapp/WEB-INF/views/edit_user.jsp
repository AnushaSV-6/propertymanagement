<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rees.model.User" %>
<%
    User user = (User) request.getAttribute("user");
%>
<html>
<head>
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
<div class="container">
    <h2>Edit User</h2>
    <form action="<%= request.getContextPath() %>/admin/users/update" method="post">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <div class="mb-3">
            <label>Email:</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" class="form-control" readonly>
    <input type="hidden" name="email" value="<%= user.getEmail() %>">
        </div>
        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" value="<%= user.getPassword() %>" class="form-control" readonly>
<input type="hidden" name="password" value="<%= user.getPassword() %>">
        </div>
        <div class="mb-3">
            <label>Name:</label>
            <input type="text" name="name" value="<%= user.getName() %>" class="form-control" readonly>
            <input type="hidden" name="name" value="<%= user.getName() %>">
            
        </div>
        <div class="mb-3">
            <label>Phone:</label>
            <input type="text" name="phone" value="<%= user.getPhone() %>" class="form-control" readonly>
            <input type="hidden" name="phone" value="<%= user.getPhone() %>">
            
        </div>
        <div class="mb-3">
            <label>Role:</label>
            <select name="role" class="form-select">
                <option value="customer" <%= "customer".equals(user.getRole()) ? "selected" : "" %>>Customer</option>
                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
            </select>
        </div>
        <div class="mb-3">
            <label>Status:</label>
            <select name="status" class="form-select">
                <option value="active" <%= "active".equals(user.getStatus()) ? "selected" : "" %>>Active</option>
                <option value="inactive" <%= "inactive".equals(user.getStatus()) ? "selected" : "" %>>Inactive</option>
                <option value="pending" <%= "pending".equals(user.getStatus()) ? "selected" : "" %>>Pending</option>
            </select>
        </div>
        <div class="mb-3">
            <label>Registered On:</label>
            <input type="text" value="<%= user.getCreatedAt() %>" class="form-control" readonly>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
<a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
