<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.rees.model.Plot" %>
<%
    List<Plot> plots = (List<Plot>) request.getAttribute("plots");
    String msg = (String) request.getAttribute("msg");
%>
<html>
<head>
    <title>Plot List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f4f4f4;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .filter-form {
            text-align: center;
            margin-bottom: 20px;
        }
        .filter-form label {
            margin: 0 10px;
            font-weight: bold;
        }
    </style>
    <script>
        function filterByStatus(status) {
            const rows = document.querySelectorAll("table tbody tr");
            rows.forEach(row => {
                const cell = row.querySelector("td:nth-child(8)"); // 8th column is Status
                if (status === 'ALL' || (cell && cell.innerText.trim() === status)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
    </script>
</head>
<body>

<h2>Plot List</h2>

<% if (msg != null && !msg.trim().isEmpty()) { %>
    <p style="color: green; text-align:center;"><%= msg %></p>
<% } %>

<div class="filter-form">
    <label><input type="radio" name="status" value="ALL" checked onclick="filterByStatus('ALL')"> All</label>
    <label><input type="radio" name="status" value="AVAILABLE" onclick="filterByStatus('AVAILABLE')"> Available</label>
    <label><input type="radio" name="status" value="BOOKED" onclick="filterByStatus('BOOKED')"> Booked</label>
    <label><input type="radio" name="status" value="SOLD" onclick="filterByStatus('SOLD')"> Sold</label>
</div>

<% if (plots != null && !plots.isEmpty()) { %>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Project</th>
            <th>Site No</th>
            <th>Size</th>
            <th>Facing</th>
            <th>Type</th>
            <th>Road Width</th>
            <th>Status</th>
            <th>Customer</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <% for (Plot p : plots) {
            if (p != null) {
        %>
        <tr>
            <td><%= p.getPlotId() %></td>
            <td><%= (p.getProject() != null) ? p.getProject().getProjectName() : "-" %></td>
            <td><%= p.getSiteNumber() %></td>
            <td><%= p.getSize() %></td>
            <td><%= p.getFacing() %></td>
            <td><%= p.getType() %></td>
            <td><%= p.getRoadWidth() %></td>
            <td><%= (p.getStatus() != null) ? p.getStatus().toString() : "-" %></td>
            <td><%= (p.getCustomer() != null) ? p.getCustomer().getName() : "-" %></td>
            <td><a href="/admin/plots/edit/<%= p.getPlotId() %>">Edit</a></td>
        </tr>
        <%  }
        } %>
    </tbody>
</table>
<% } else { %>
    <p style="text-align: center; font-weight: bold; color: red;">No plots found.</p>
<% } %>

</body>
</html>
