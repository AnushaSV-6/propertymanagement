<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.rees.model.Project" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Project</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            padding: 50px;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-bottom: 25px;
        }

        label {
            font-weight: 500;
        }

        .form-control, .form-select {
            margin-bottom: 15px;
        }

        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/admin/projects" class="btn btn-secondary mb-3">&larr; Back to Manage Projects</a>

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
                    List<Project> allProjects = (List<Project>) request.getAttribute("allProjects");
                    Integer selectedId = request.getParameter("projectId") != null ?
                                         Integer.parseInt(request.getParameter("projectId")) : null;
                    for (Project p : allProjects) {
                %>
                <option value="<%=p.getProjectId()%>" <%= (selectedId != null && selectedId == p.getProjectId()) ? "selected" : "" %>>
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
        Project selectedProject = (Project) request.getAttribute("project");
        if (selectedProject != null) {
    %>
    <form method="post" action="update">
        <input type="hidden" name="projectId" value="<%=selectedProject.getProjectId()%>" />

        <div class="mb-3">
            <label class="form-label">Project Name:</label>
            <input type="text" name="projectName" class="form-control" value="<%=selectedProject.getProjectName()%>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Survey Number:</label>
            <input type="text" name="surveyNumber" class="form-control" value="<%=selectedProject.getSurveyNumber()%>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Location:</label>
            <input type="text" name="location" class="form-control" value="<%=selectedProject.getLocation()%>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Total Area:</label>
            <input type="text" name="totalArea" class="form-control" value="<%=selectedProject.getTotalArea()%>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Saleable Area:</label>
            <input type="text" name="saleableArea" class="form-control" value="<%=selectedProject.getSaleableArea()%>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Project Type:</label>
            <select name="projectType" class="form-select">
                <option value="JV" <%= "JV".equals(selectedProject.getProjectType().name()) ? "selected" : "" %>>JV</option>
                <option value="OWN" <%= "OWN".equals(selectedProject.getProjectType().name()) ? "selected" : "" %>>OWN</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Project Status:</label>
            <select name="projectStatus" class="form-select">
                <option value="COMPLETED" <%= "COMPLETED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>COMPLETED</option>
                <option value="STARTED" <%= "STARTED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>STARTED</option>
                <option value="REGISTERED" <%= "REGISTERED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>REGISTERED</option>
                <option value="JV" <%= "JV".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>JV</option>
                <option value="PURCHASED" <%= "PURCHASED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>PURCHASED</option>
                <option value="UNDER_AGREEMENT" <%= "UNDER_AGREEMENT".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>UNDER AGREEMENT</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Map PDF Path:</label>
            <input type="text" name="mapPdf" class="form-control" value="<%=selectedProject.getMapPdf()%>" />
        </div>

        <button type="submit" class="btn btn-success">Update Project</button>
    </form>
    <%
        }
    %>
</div>
</body>
</html>
