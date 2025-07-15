<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.rees.model.User" %>
<html>
<head>
    <title>User List</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        a { margin-right: 10px; }
    </style>
</head>
<body>
    <h2>All Users</h2>
    <a href="users/add">Add New User</a>
    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>Email</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Status</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<User> users = (List<User>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (User user : users) {
            %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getName() %></td>
                <td><%= user.getPhone() %></td>
                <td><%= user.getRole() %></td>
                <td><%= user.getStatus() %></td>
                <td><%= user.getCreatedAt() %></td>
                <td>
                    <a href="<%= request.getContextPath() %>/admin/users/edit/<%= user.getUserId() %>">Edit</a>
                    <a href="<%= request.getContextPath() %>/admin/users/deactivate/<%= user.getUserId() %>" onclick="return confirm('Deactivate this user?');">Deactivate</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="8">No users found.</td></tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
