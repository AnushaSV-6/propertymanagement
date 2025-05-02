<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.rees.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
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

<div class="container">
    <h2>Customer List</h2>

    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null && !message.isEmpty()) { %>
        <div class="alert alert-info">
            <%= message %>
        </div>
    <% } %>

    <%
        List<Customer> customers = (List<Customer>) request.getAttribute("customers");
        if (customers == null || customers.isEmpty()) {
    %>
        <p>No customers found.</p>
    <%
        } else {
    %>
        <table class="table table-striped table-bordered mt-3">
            <thead class="table-dark">
                <tr>
                    <th>#ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Aadhaar</th>
                    <th>PAN</th>
                    <th>Address</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                <% for (Customer c : customers) { %>
                    <tr>
                        <td><%= c.getCustomerId() %></td>
                        <td><%= c.getName() %></td>
                        <td><%= c.getContactNumber() %></td>
                        <td><%= c.getAadhaarNumber() %></td>
                        <td><%= c.getPanNumber() %></td>
                        <td><%= c.getAddress() %></td>
                        <td><%= c.getCreatedAt() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <%
        }
    %>
</div>

</body>
</html>
