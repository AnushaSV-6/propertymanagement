<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.Plot" %>

<html>
<head>
    <title>View Plots</title>
</head>
<body>
    <h2>Plot List</h2>

    <%
        // The 'plots' attribute will be automatically provided by the model
        List<Plot> plots = (List<Plot>) request.getAttribute("plots");
        String error = (String) request.getAttribute("error");
    %>

    <!-- Display error message if any -->
    <%
        if (error != null) {
            out.println("<p style='color:red;'>" + error + "</p>");
        }
    %>

    <!-- Check if the plots list is empty -->
    <%
        if (plots == null || plots.isEmpty()) {
            out.println("<p>No plots available.</p>");
        } else {
    %>
        <!-- Display plots in a table -->
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>Plot ID</th>
                <th>Site Number</th>
                <th>Size</th>
                <th>Facing</th>
                <th>Type</th>
                <th>Road Width</th>
                <th>Status</th>
                <th>Created At</th>
                <th>Project Name</th>
            </tr>
            <%
                for (Plot plot : plots) {
            %>
            <tr>
                <td><%= plot.getPlotId() %></td>
                <td><%= plot.getSiteNumber() %></td>
                <td><%= plot.getSize() %></td>
                <td><%= plot.getFacing() %></td>
                <td><%= plot.getType() %></td>
                <td><%= plot.getRoadWidth() %></td>
                <td><%= plot.getStatus() %></td>
                <td><%= plot.getCreatedAt() %></td>
                <td><%= plot.getProject() != null ? plot.getProject().getProjectName() : "N/A" %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
</body>
</html>
