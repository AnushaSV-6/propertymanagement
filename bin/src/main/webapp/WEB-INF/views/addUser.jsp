<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rees.model.User" %>
<html>
<head>
    <title>Add New User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
<div class="container">
    <h2>Add New User</h2>
    <form action="save" method="post">
        <div class="mb-3">
            <label>User ID:</label>
            <input type="text" name="userId" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Email:</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Name:</label>
            <input type="text" name="name" class="form-control">
        </div>
        <div class="mb-3">
            <label>Phone:</label>
            <input type="text" name="phone" class="form-control">
        </div>
        <div class="mb-3">
            <label>Role:</label>
            <select name="role" class="form-select">
                <option value="customer">Customer</option>
                <option value="admin">Admin</option>
            </select>
        </div>
        <div class="mb-3">
            <label>Status:</label>
            <select name="status" class="form-select">
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
                <option value="pending">Pending</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Save</button>
        <a href=".." class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
