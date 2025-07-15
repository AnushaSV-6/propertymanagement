<%@ page import="java.util.List, com.rees.model.Project" %>
<%
    List<Project> projects = (List<Project>) request.getAttribute("projects");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>

    <!-- Heading Section Outside the Box -->
    <div class="heading-container">
        <h2>Welcome to the Project Selection Portal</h2>
        <p class="intro-text">Select a project from the list below to view available plots.</p>
    </div>

    <!-- Main Box -->
    <div class="container">
        <h3>Project Selection</h3>
        <form action="availableplots" method="post">
            <label for="projectSelect" class="form-label">Select Project:</label>
            <select class="form-select" name="projectId" id="projectSelect" required>
                <option value="">-- Select a Project --</option>
                <% if (projects != null && !projects.isEmpty()) {
                    for (Project p : projects) { %>
                        <option value="<%= p.getProjectId() %>"><%= p.getName() %></option>
                <%  } } else { %>
                    <option value="">No Projects Available</option>
                <% } %>
            </select>
            <br>
            <button type="submit" class="btn btn-primary">View Available Plots</button>
        </form>
    </div>

    <p class="footer-text">Need help? Contact support for assistance.</p>

</body>
</html>
