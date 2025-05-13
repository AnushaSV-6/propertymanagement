<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.Project" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Projects</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            padding: 50px;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-bottom: 20px;
        }

        table {
            margin-top: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/projects" class="btn btn-secondary mb-3">&larr; Back to Manage Projects</a>

        <h2>Project List</h2>

        <%
            List<Project> projects = (List<Project>) request.getAttribute("projects");
            String error = (String) request.getAttribute("error");
        %>

        <!-- Display error message if any -->
        <%
            if (error != null) {
        %>
            <div class="alert alert-danger">
                <%= error %>
            </div>
        <%
            }
        %>

        <!-- Check if the projects list is empty -->
        <%
            if (projects == null || projects.isEmpty()) {
        %>
            <div class="alert alert-info">No projects available.</div>
        <%
            } else {
        %>

        <!-- Display projects in a Bootstrap table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
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
                </thead>
                <tbody>
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
                </tbody>
            </table>
        </div>

        <%
            }
        %>
    </div>
</body>
</html>
