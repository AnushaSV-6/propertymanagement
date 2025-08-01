<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.dto.CustomerDTO" %>
<%
    List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
	        padding: 40px;
	    }
	    .container {
	        background-color: white;
	        padding: 30px;
	        border-radius: 12px;
	        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
	    }
	    h2 {
	        text-align: center;
	        margin-bottom: 25px;
	    }
	</style>
</head>
<body>

<div class="container mt-5">
    <a href="${pageContext.request.contextPath}/rees/admin/customers" 	class="back-button">
				    <i class="bi bi-arrow-left"></i> Back
	    </a>
    <h2 class="text-center mb-4">Customer List</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>Name</th>
            <th>Contact</th>
            <th>Aadhaar</th>
            <th>PAN</th>
            <th>Address</th>
           
        </tr>
        </thead>
        <tbody>
        <% if (customers != null) {
            for (CustomerDTO c : customers) { %>
            <tr>
                <td><%= c.getName() %></td>
                <td><%= c.getContactNumber() %></td>
                <td><%= c.getAadhaarNumber() %></td>
                <td><%= c.getPanNumber() %></td>
                <td><%= c.getAddress() %></td>
                
            </tr>
        <% }} %>
        </tbody>
    </table>
</div>

</body>
</html>
