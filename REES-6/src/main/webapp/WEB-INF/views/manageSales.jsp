<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Sales</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            padding-top: 60px;
            font-family: "Poppins", sans-serif;
        }

        .container {
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h3 {
            margin-bottom: 30px;
        }

        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .btn {
            font-size: 18px;
            padding: 12px;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="${pageContext.request.contextPath}/adminDashboard" class="btn btn-secondary mb-3">&larr;  Back to Admin Dashboard
</a>
    <h3>Manage Sales</h3>

    <div class="btn-group">
			
        <a href="${pageContext.request.contextPath}/admin/sales/add" class="btn btn-primary">Add New Sale</a>
        <a href="${pageContext.request.contextPath}/admin/sales/update" class="btn btn-warning">Update Existing Sale</a>
    </div>
</div>

</body>
</html>
