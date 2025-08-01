<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.rees.dto.ProjectDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Project</title>
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
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            padding: 60px 15px;
        }

        .container {
            max-width: 900px;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-bottom: 30px;
            font-weight: 600;
        }

        .form-label {
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 10px;
        }

        .btn {
            border-radius: 10px;
            font-weight: 500;
            padding: 10px 25px;
        }

	
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/rees/admin/projects" 	class="back-button">
	    <i class="bi bi-arrow-left"></i> Back
    </a>

    <h2>Update Project</h2>

    <%
        String success = (String) request.getAttribute("success");
        String error = (String) request.getAttribute("error");
    %>

    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <!-- Step 1: Select Project -->
    <form method="get" action="updateproject" class="mb-4">
        <div class="mb-3">
            <label class="form-label">Select Project to Update:</label>
            <select name="projectId" class="form-select">
                <%
                    List<ProjectDTO> allProjects = (List<ProjectDTO>) request.getAttribute("allProjects");
                    Integer selectedId = request.getParameter("projectId") != null ?
                                         Integer.parseInt(request.getParameter("projectId")) : null;
                    for (ProjectDTO p : allProjects) {
                %>
                <option value="<%=p.getProjectId()%>" <%= (selectedId != null && selectedId.equals(p.getProjectId())) ? "selected" : "" %>>
                    <%=p.getProjectName()%>
                </option>
                <%
                    }
                %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Load Project</button>
    </form>

    <!-- Step 2: Update Form -->
    <%
        ProjectDTO selectedProject = (ProjectDTO) request.getAttribute("project");
        if (selectedProject != null) {
    %>
    <form method="post" action="update">
        <input type="hidden" name="projectId" value="<%=selectedProject.getProjectId()%>" />

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">Project Name</label>
                <input type="text" name="projectName" class="form-control" value="<%=selectedProject.getProjectName()%>" required />
            </div>
            <div class="col-md-6">
                <label class="form-label">Survey Number</label>
                <input type="text" name="surveyNumber" class="form-control" value="<%=selectedProject.getSurveyNumber()%>" required />
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">Location</label>
                <input type="text" name="location" class="form-control" value="<%=selectedProject.getLocation()%>" required />
            </div>
            <div class="col-md-6">
                <label class="form-label">Total Area</label>
                <input type="text" name="totalArea" class="form-control" value="<%=selectedProject.getTotalArea()%>" required />
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">Saleable Area</label>
                <input type="text" name="saleableArea" class="form-control" value="<%=selectedProject.getSaleableArea()%>" required />
            </div>
            <div class="col-md-6">
                <label class="form-label">Project Type</label>
                <select name="projectType" class="form-select" required>
                    <option value="OWN" <%= selectedProject.getProjectType() != null && "OWN".equals(selectedProject.getProjectType().name()) ? "selected" : "" %>>OWN</option>
                    <option value="JV" <%= selectedProject.getProjectType() != null && "JV".equals(selectedProject.getProjectType().name()) ? "selected" : "" %>>JV</option>
                </select>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">Project Status</label>
                <select name="projectStatus" class="form-select" required>
                    <%
                        String status = selectedProject.getProjectStatus() != null ? selectedProject.getProjectStatus().name() : "";
                    %>
                    <option value="STARTED" <%= "STARTED".equals(status) ? "selected" : "" %>>STARTED</option>
                    <option value="REGISTERED" <%= "REGISTERED".equals(status) ? "selected" : "" %>>REGISTERED</option>
                    <option value="COMPLETED" <%= "COMPLETED".equals(status) ? "selected" : "" %>>COMPLETED</option>
                    <option value="PURCHASED" <%= "PURCHASED".equals(status) ? "selected" : "" %>>PURCHASED</option>
                    <option value="UNDERAGREEMENT" <%= "UNDERAGREEMENT".equals(status) ? "selected" : "" %>>UNDER AGREEMENT</option>
                    <option value="JV" <%= "JV".equals(status) ? "selected" : "" %>>JV</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label">Map PDF Path</label>
                <input type="text" name="mapPdf" class="form-control" value="<%=selectedProject.getMapPdf()%>" />
            </div>
        </div>

        <div class="text-end">
            <button type="submit" class="btn btn-success">Update Project</button>
        </div>
    </form>
    <% } %>
</div>
</body>
</html>
