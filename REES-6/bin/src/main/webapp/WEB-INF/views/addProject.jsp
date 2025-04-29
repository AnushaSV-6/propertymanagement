<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rees.model.Project" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Project</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            padding-top: 60px;
            font-family: "Poppins", sans-serif;
        }
        .container {
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h3 {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>Add New Project</h3>
    <% 
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");

    if (message != null) {
%>
    <div class="alert alert-success" role="alert">
        <%= message %>
    </div>
<% 
    } else if (error != null) {
%>
    <div class="alert alert-danger" role="alert">
        <%= error %>
    </div>
<% 
    } 
%>
    
    <form action="${pageContext.request.contextPath}/admin/projects/save" method="post">
        <div class="mb-3">
            <label for="projectName" class="form-label">Project Name</label>
            <input type="text" name="projectName" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="surveyNumber" class="form-label">Survey Number</label>
            <input type="text" name="surveyNumber" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="location" class="form-label">Location</label>
            <input type="text" name="location" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="totalArea" class="form-label">Total Area</label>
            <input type="number" step="0.01" name="totalArea" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="saleableArea" class="form-label">Saleable Area</label>
            <input type="number" step="0.01" name="saleableArea" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="projectType" class="form-label">Project Type</label>
            <select name="projectType" class="form-select" required>
                <option value="OWN">OWN</option>
                <option value="JV">JV</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="projectStatus" class="form-label">Project Status</label>
            <select name="projectStatus" class="form-select" required>
                <option value="STARTED">STARTED</option>
                <option value="REGISTERED">REGISTERED</option>
                <option value="COMPLETED">COMPLETED</option>
                <option value="PURCHASED">PURCHASED</option>
                <option value="UNDER_AGREEMENT">UNDER AGREEMENT</option>
                <option value="JV">JV</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="mapPdf" class="form-label">Map PDF Path</label>
            <input type="text" name="mapPdf" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">Save Project</button>
    </form>
</div>
</body>
</html>  