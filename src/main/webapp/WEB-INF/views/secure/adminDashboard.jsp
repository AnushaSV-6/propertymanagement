<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");

    if (email == null || !"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/public/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            display: flex;
            background-color: #f8f9fa;
        }

        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: white;
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sidebar h4 {
            color: #ffffff;
            margin-bottom: 30px;
            text-align: center;
        }

        .nav-btn {
            background-color: transparent;
            border: none;
            color: white;
            text-align: left;
            width: 100%;
            padding: 12px 10px;
            font-size: 16px;
            margin-bottom: 10px;
            border-radius: 5px;
            transition: background-color 0.2s;
        }

        .nav-btn:hover {
            background-color: #495057;
        }

        .logout-btn {
            background-color: #dc3545;
            border: none;
            padding: 10px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background-color: #b52a37;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        .dashboard-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .dashboard-card {
            display: flex;
            align-items: center;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
            width: 240px;
            transition: transform 0.2s;
            text-decoration: none;
            color: #333;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            background-color: #f1f1f1;
        }

        .dashboard-card i {
            font-size: 28px;
            margin-right: 15px;
            color: #0d6efd;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div>
        <h4>Admin Panel</h4>
        <button class="nav-btn" onclick="showSection('manage')"><i class="bi bi-tools"></i> Manage</button>
        <button class="nav-btn" onclick="showSection('reports')"><i class="bi bi-graph-up"></i> Reports</button>
    </div>

    <button class="logout-btn" onclick="window.location.href='<%= request.getContextPath() %>/rees/admin/logout'">
        <i class="bi bi-box-arrow-right"></i> Logout
    </button>
</div>

<div class="main-content">
    <div id="manage-section" class="dashboard-section">
        <h2>Manage Entities</h2>
        <div class="dashboard-row">
            <a href="<%= request.getContextPath() %>/rees/admin/projects" class="dashboard-card">
                <i class="bi bi-map"></i> Projects
            </a>
            <a href="<%= request.getContextPath() %>/rees/admin/plots" class="dashboard-card">
                <i class="bi bi-grid-3x3-gap-fill"></i> Plots
            </a>
            <a href="<%= request.getContextPath() %>/rees/admin/customers" class="dashboard-card">
                <i class="bi bi-person-circle"></i> Customers
            </a>
            <a href="<%= request.getContextPath() %>/rees/admin/sales" class="dashboard-card">
                <i class="bi bi-currency-rupee"></i> Sales
            </a>
            <a href="<%= request.getContextPath() %>/rees/admin/inquirer" class="dashboard-card">
                <i class="bi bi-question-circle"></i> Inquiries
            </a>
        </div>
    </div>

    <div id="reports-section" class="dashboard-section" style="display: none;">
        <h2>Reports & Stats</h2>
        <p>This section can later include analytics like:</p>
        <ul>
            <li>Total Sales vs Pending</li>
            <li>Monthly Inquiry Stats</li>
            <li>Project-wise Plot Summary</li>
            <li>CSV Export Options</li>
        </ul>
    </div>
</div>

<script>
    function showSection(section) {
        document.getElementById('manage-section').style.display = section === 'manage' ? 'block' : 'none';
        document.getElementById('reports-section').style.display = section === 'reports' ? 'block' : 'none';
    }
</script>

</body>
</html>
