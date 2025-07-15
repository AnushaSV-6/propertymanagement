<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: "Poppins", Arial, sans-serif;
            background: url('<%= request.getContextPath() %>/images/admin.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 60%;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        h2 {
            color: #333;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .dashboard-menu {
            margin-top: 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .dashboard-card {
            background: #007bff;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            transition: background 0.3s ease-in-out, transform 0.2s;
        }

        .dashboard-card:hover {
            background: #0056b3;
            transform: scale(1.05);
        }

        .logout-btn {
            margin-top: 30px;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            border: none;
            background: linear-gradient(to right, #dc3545, #c82333);
            color: white;
            transition: background 0.3s ease-in-out, transform 0.2s;
        }

        .logout-btn:hover {
            background: linear-gradient(to right, #b71c1c, #900c3f);
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome to Admin Dashboard</h2>
    <p>You have admin privileges.</p>

    <div class="dashboard-menu">
        <a href="<%= request.getContextPath() %>/admin/projects" class="dashboard-card">Manage Projects</a>
        <a href="<%= request.getContextPath() %>/admin/plots" class="dashboard-card">Manage Plots</a>
        <a href="<%= request.getContextPath() %>/admin/customers" class="dashboard-card">Manage Customers</a>
        <a href="<%= request.getContextPath() %>/admin/sales" class="dashboard-card">Manage Sales</a>
<a href="<%= request.getContextPath() %>/admin/inquirer" class="dashboard-card">Manage Plot Inquiries</a>
    </div>

    <button class="logout-btn" onclick="window.location.href='<%= request.getContextPath() %>/logout'">Logout</button>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
