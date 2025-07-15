<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
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
        .btn-success {
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container">
	<a href="${pageContext.request.contextPath}/rees/admin/customers" style="position: fixed; top: 20px; left: 20px; z-index: 1000; background: white; padding: 10px 15px; border-radius: 12px; box-shadow: 0 2px 6px rgba(0,0,0,0.2); text-decoration: none; color: black; display: flex; align-items: center;">
   <img src="${pageContext.request.contextPath}/images/backbutton.png" alt="Back" style="height: 20px; margin-right: 8px;">
   <span>Back</span></a>

    <h2>Add Customer</h2>

    <% if (request.getAttribute("message") != null) { %>
        <div class="alert alert-info">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/admin/customers/save" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea name="address" class="form-control" rows="2" required></textarea>
        </div>
        <div class="mb-3">
            <label for="contactNumber" class="form-label">Contact Number</label>
            <input type="text" name="contactNumber" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="aadhaarNumber" class="form-label">Aadhaar Number</label>
            <input type="text" name="aadhaarNumber" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="panNumber" class="form-label">PAN Number</label>
            <input type="text" name="panNumber" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-success">Save Customer</button>
    </form>
</div>

</body>
</html>
