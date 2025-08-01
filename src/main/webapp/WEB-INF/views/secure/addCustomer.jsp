<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rees.dto.CustomerDTO" %>
<%
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
			<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

			<style>
			    .back-button {
			        position: absolute;
			        top: 20px;
			        left: 20px;
			        background: white;
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
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f2f2f2;
            padding: 50px;
        }
        .container {
            max-width: 600px;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
        }
        h2 {
            margin-bottom: 30px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="${pageContext.request.contextPath}/rees/admin/customers" 	class="back-button">
				    <i class="bi bi-arrow-left"></i> Back
	    </a>

    <h2>Add Customer</h2>

    <% if (message != null) { %>
        <div class="alert alert-info"><%= message %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/rees/admin/customers/save" method="post">
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact Number</label>
            <input type="text" name="contactNumber" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Aadhaar Number</label>
            <input type="text" name="aadhaarNumber" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">PAN Number</label>
            <input type="text" name="panNumber" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-success">Save Customer</button>
    </form>
</div>

</body>
</html>
