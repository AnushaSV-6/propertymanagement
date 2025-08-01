<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.Project" %>
<%@ page import="com.rees.dto.ProjectDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Projects</title>
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
        <a href="${pageContext.request.contextPath}/rees/admin/projects" 		class="back-button">
		    <i class="bi bi-arrow-left"></i> Back</a>

        <h2>Project List</h2>

        
		<%
		        List<ProjectDTO> projects = (List<ProjectDTO>) request.getAttribute("projects");
		        String error = (String) request.getAttribute("error");
		    %>

		    <% if (error != null) { %>
		        <div class="alert alert-danger"><%= error %></div>
		    <% } %>

		    <% if (projects != null && !projects.isEmpty()) { %>
		        <table class="table table-bordered">
		            <thead class="thead-dark">
		            <tr>
		               
		                <th>Name</th>
		                <th>Survey Number</th>
		                <th>Location</th>
		                <th>Total Area</th>
		                <th>Saleable Area</th>
		                <th>Type</th>
		                <th>Status</th>
		                
		            </tr>
		            </thead>
		            <tbody>
		            <% for (ProjectDTO project : projects) { %>
		                <tr>
		                    
		                    <td><%= project.getProjectName() %></td>
		                    <td><%= project.getSurveyNumber() %></td>
		                    <td><%= project.getLocation() %></td>
		                    <td><%= project.getTotalArea() %></td>
		                    <td><%= project.getSaleableArea() %></td>
		                    <td><%= project.getProjectType() %></td>
		                    <td><%= project.getProjectStatus() %></td>
		                   
		                </tr>
		            <% } %>
		            </tbody>
		        </table>
		    <% } else { %>
		        <div class="alert alert-info">No projects found.</div>
		    <% } %>
    </div>
</body>
</html>
