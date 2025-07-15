<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Customers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
			background: url('<%= request.getContextPath() %>/assets/img/admin.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card-box {
            width: 380px;
            background: rgba(255, 255, 255, 0.95);
            padding: 35px 25px;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h2 {
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .btn-option {
            width: 100%;
            margin: 10px 0;
            padding: 14px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s ease, background-color 0.2s ease;
        }

        .btn-option i {
            margin-right: 10px;
            font-size: 18px;
        }

        .btn-option:hover {
            transform: translateY(-2px);
        }

        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background: #fff;
            padding: 10px 16px;
            border-radius: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            color: #333;
            font-weight: 500;
            text-decoration: none;
            transition: background 0.3s, transform 0.2s;
        }

        .back-button i {
            margin-right: 8px;
        }

        .back-button:hover {
            background: #e0e0e0;
            transform: scale(1.05);
            text-decoration: none;
        }
    </style>
</head>
<body>

<!-- Back Button -->
<a href="${pageContext.request.contextPath}/rees/adminDashboard" class="back-button">
    <i class="bi bi-arrow-left"></i> Back
</a>

<div class="card-box">
    <h2>Manage Customers</h2>

    <a href="${pageContext.request.contextPath}/rees/admin/customers/add" class="btn btn-primary btn-option">
        <i class="bi bi-person-plus"></i> Add Customer
    </a>

    <a href="${pageContext.request.contextPath}/rees/admin/customers/list" class="btn btn-secondary btn-option">
        <i class="bi bi-people-fill"></i> View Customers
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
