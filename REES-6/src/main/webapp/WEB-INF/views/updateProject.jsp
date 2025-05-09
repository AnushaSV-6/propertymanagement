
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.rees.model.Project" %>
<html>
<head>
    <title>Update Project</title>
</head>
<body>
<%
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
%>

<% if (success != null) { %>
    <div style="color: green; font-weight: bold;"><%= success %></div>
<% } %>

<% if (error != null) { %>
    <div style="color: red; font-weight: bold;"><%= error %></div>
<% } %>


<h2>Update Project</h2>

<!-- Step 1: Project Dropdown -->
<form method="get" action="updateproject">
    <label>Select Project to Update:</label>
    <select name="projectId">
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
    <button type="submit">Load Project</button>
</form>

<!-- Step 2: Update Form (Only if project is selected) -->
<%
    Project selectedProject = (Project) request.getAttribute("project");
    if (selectedProject != null) {
%>
    <form method="post" action="update">
        <input type="hidden" name="projectId" value="<%=selectedProject.getProjectId()%>" />

        <label>Project Name:</label>
        <input type="text" name="projectName" value="<%=selectedProject.getProjectName()%>" /><br/>

        <label>Survey Number:</label>
        <input type="text" name="surveyNumber" value="<%=selectedProject.getSurveyNumber()%>" /><br/>

        <label>Location:</label>
        <input type="text" name="location" value="<%=selectedProject.getLocation()%>" /><br/>

        <label>Total Area:</label>
        <input type="text" name="totalArea"  value="<%=selectedProject.getTotalArea()%>" /><br/>

        <label>Saleable Area:</label>
        <input type="text" name="saleableArea"  value="<%=selectedProject.getSaleableArea()%>" /><br/>

        <label>Project Type:</label>
        <select name="projectType">
            <option value="JV" <%= "JV".equals(selectedProject.getProjectType().name()) ? "selected" : "" %>>JV</option>
            <option value="OWN" <%= "OWN".equals(selectedProject.getProjectType().name()) ? "selected" : "" %>>OWN</option>
        </select><br/>

        <label>Project Status:</label>
        <select name="projectStatus">
            <option value="COMPLETED" <%= "COMPLETED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>COMPLETED</option>
            <option value="STARTED" <%= "STARTED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>STARTED</option>
            <option value="REGISTERED" <%= "REGISTERED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>REGISTERED</option>
            <option value="JV" <%= "JV".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>JV</option>
            <option value="PURCHASED" <%= "PURCHASED".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>PURCHASED</option>
            <option value="UNDER_AGREEMENT" <%= "UNDER_AGREEMENT".equals(selectedProject.getProjectStatus().name()) ? "selected" : "" %>>UNDER AGREEMENT</option>
        </select><br/>

        <label>Map PDF Path:</label>
        <input type="text" name="mapPdf" value="<%=selectedProject.getMapPdf()%>" /><br/>

        <button type="submit">Update Project</button>
    </form>
<%
    }
%>

</body>
</html>
