<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.rees.model.Plot, com.rees.model.Project" %>
<%
    List<Plot> plots = (List<Plot>) request.getAttribute("plots");
    List<Project> projects = (List<Project>) request.getAttribute("projects");
    Integer selectedProjectId = (Integer) request.getAttribute("selectedProjectId");
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
                const cell = row.querySelector("td[data-status]");
                if (status === 'ALL' || (cell && cell.innerText.trim() === status)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Optional: Apply status filtering on page load based on selected status (if any)
        window.onload = function() {
            const selectedStatus = document.querySelector('input[name="status"]:checked');
            if (selectedStatus) {
                filterByStatus(selectedStatus.value);
            }
        }
    </script>
</head>
<body>

<h2>Plot List</h2>

<div class="filter-form">
<form action="${pageContext.request.contextPath}/admin/plots/list" method="GET">
        <label for="projectId">Select Project:</label>
        <select name="projectId" id="projectId" required>
            <option value="">-- Select --</option>
            <%
                if (projects != null) {
                    for (Project proj : projects) {
                        String selected = (selectedProjectId != null && proj.getProjectId() == selectedProjectId) ? "selected" : "";
            %>
            <option value="<%= proj.getProjectId() %>" <%= selected %>><%= proj.getProjectName() %></option>
            <%
                    }
                }
            %>
        </select>
        <button type="submit">Load</button>
    </form>
</div>

<%
    if (plots != null && !plots.isEmpty()) {
%>

<div class="filter-form">
    <label><input type="radio" name="status" value="ALL" checked onclick="filterByStatus('ALL')"> All</label>
    <label><input type="radio" name="status" value="AVAILABLE" onclick="filterByStatus('AVAILABLE')"> Available</label>
    <label><input type="radio" name="status" value="BOOKED" onclick="filterByStatus('BOOKED')"> Booked</label>
    <label><input type="radio" name="status" value="SALED" onclick="filterByStatus('SALED')"> Saled</label>
</div>

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
    <%
        for (Plot p : plots) {
    %>
        <tr>
            <td><%= p.getPlotId() %></td>
            <td><%= p.getProject() != null ? p.getProject().getProjectName() : "-" %></td>
            <td><%= p.getSiteNumber() %></td>
            <td><%= p.getSize() %></td>
            <td><%= p.getFacing() %></td>
            <td><%= p.getType() %></td>
            <td><%= p.getRoadWidth() %></td>
            <td data-status="<%= p.getStatus() != null ? p.getStatus().toString().toUpperCase() : "" %>"><%= p.getStatus() %></td>
            <td><%= p.getCustomer() != null ? p.getCustomer().getName() : "-" %></td>
            <td>
                <form action="${pageContext.request.contextPath}/admin/plots/edit" method="post" style="margin: 0;">
                    <input type="hidden" name="plotId" value="<%= p.getPlotId() %>" />
                    <button type="submit">Edit</button>
                </form>
            </td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

<%
    } else if (selectedProjectId != null) {
%>
    <p style="text-align: center; font-weight: bold; color: red;">No plots found for selected project.</p>
<%
    }
%>

</body>
</html>
