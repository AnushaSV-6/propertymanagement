<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.Project" %>

<html>
<head>
    <title>View Projects</title>
</head>
<body>
    <h2>Project List</h2>

    <%
        // The 'projects' attribute will be automatically provided by the model
        List<Project> projects = (List<Project>) request.getAttribute("projects");
        String error = (String) request.getAttribute("error");
    %>

    <!-- Display error message if any -->
    <%
        if (error != null) {
            out.println("<p style='color:red;'>" + error + "</p>");
        }
    %>

    <!-- Check if the projects list is empty -->
    <%
        if (projects == null || projects.isEmpty()) {
            out.println("<p>No projects available.</p>");
        } else {
    %>
        <!-- Display projects in a table -->
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Survey No</th>
                <th>Location</th>
                <th>Total Area</th>
                <th>Saleable Area</th>
                <th>Type</th>
                <th>Status</th>
                <th>Map PDF</th>
            </tr>
            <%
                for (Project project : projects) {
            %>
            <tr>
                <td><%= project.getProjectId() %></td>
                <td><%= project.getProjectName() %></td>
                <td><%= project.getSurveyNumber() %></td>
                <td><%= project.getLocation() %></td>
                <td><%= project.getTotalArea() %></td>
                <td><%= project.getSaleableArea() %></td>
                <td><%= project.getProjectType() %></td>
                <td><%= project.getProjectStatus() %></td>
                <td><%= project.getMapPdf() %></td>
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
