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
            margin-bottom: 30px;
        }
        .container {
            max-width: 1100px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        .filter-form {
            text-align: center;
            margin-bottom: 30px;
        }
        .filter-form label {
            margin: 0 10px;
            font-weight: bold;
        }
        .filter-form select, .filter-form button {
            padding: 10px 15px;
            font-size: 14px;
            margin-left: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .filter-form button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .filter-form button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        td[data-status="AVAILABLE"] {
            color: green;
            font-weight: bold;
        }
        td[data-status="BOOKED"] {
            color: orange;
            font-weight: bold;
        }
        td[data-status="SOLD"] {
            color: red;
            font-weight: bold;
        }
        form button {
            padding: 5px 12px;
            background-color: #28a745;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        form button:hover {
            background-color: #218838;
        }
        .status-radio {
            text-align: center;
            margin-bottom: 20px;
        }
        .status-radio label {
            margin: 0 12px;
        }
        .no-data {
            text-align: center;
            font-weight: bold;
            color: red;
            margin-top: 30px;
        }
        .back-link {
    display: inline-block;
    margin-bottom: 20px;
    padding: 10px 18px;
    background-color: #6c757d; /* Gray background similar to Bootstrap's secondary */
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    transition: background-color 0.3s ease;
}
.back-link:hover {
    background-color: #5a6268;
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

        window.onload = function () {
            const selectedStatus = document.querySelector('input[name="status"]:checked');
            if (selectedStatus) {
                filterByStatus(selectedStatus.value);
            }
        }
    </script>
</head>
<body>

<div class="container">
	<a href="${pageContext.request.contextPath}/rees/admin/plots" style="position: fixed; top: 20px; left: 20px; z-index: 1000; background: white; padding: 10px 15px; border-radius: 12px; box-shadow: 0 2px 6px rgba(0,0,0,0.2); text-decoration: none; color: black; display: flex; align-items: center;">
   <img src="${pageContext.request.contextPath}/images/backbutton.png" alt="Back" style="height: 20px; margin-right: 8px;">
   <span>Back</span></a>

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

    <div class="status-radio">
        <label><input type="radio" name="status" value="ALL" checked onclick="filterByStatus('ALL')"> All</label>
        <label><input type="radio" name="status" value="AVAILABLE" onclick="filterByStatus('AVAILABLE')"> Available</label>
        <label><input type="radio" name="status" value="BOOKED" onclick="filterByStatus('BOOKED')"> Booked</label>
        <label><input type="radio" name="status" value="SOLD" onclick="filterByStatus('SOLD')"> Sold</label>
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
                <form action="${pageContext.request.contextPath}/rees/admin/plots/edit" method="get" style="margin: 0;">
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
    <div class="no-data">No plots found for selected project.</div>
    <%
        }
    %>
</div>

</body>
</html>
