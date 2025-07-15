<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rees.model.Project" %>
<%@ page import="com.rees.model.Plot" %>
<%@ page import="java.util.List" %>
<%
    Plot plot = (Plot) request.getAttribute("plot");
    List<Project> projects = (List<Project>) request.getAttribute("projects");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Plot</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f2f2;
            font-family: 'Poppins', sans-serif;
            padding: 50px;
        }
        .container {
            max-width: 700px;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
        }
        h3 {
            margin-bottom: 25px;
            text-align: center;
        }
        .form-label {
            font-weight: 600;
        }
        .btn-success {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
        }
        .back-link {
            margin-bottom: 20px;
            display: inline-block;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/rees/admin/plots/list" style="position: fixed; top: 20px; left: 20px; z-index: 1000; background: white; padding: 10px 15px; border-radius: 12px; box-shadow: 0 2px 6px rgba(0,0,0,0.2); text-decoration: none; color: black; display: flex; align-items: center;">
   <img src="${pageContext.request.contextPath}/images/backbutton.png" alt="Back" style="height: 20px; margin-right: 8px;">
   <span>Back</span></a>
    <h3>Edit Plot</h3>

    <% if (plot == null) { %>
        <div class="alert alert-danger">
            Plot not found or not loaded properly. Please go back and try again.
        </div>
    <% } else { %>

        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/admin/plots/update" method="post">
            <input type="hidden" name="plotId" value="<%= plot.getPlotId() %>" />

            <div class="mb-3">
                <label class="form-label">Project</label>
                <select name="project.projectId" class="form-select" required>
                    <% if (projects != null) {
                        for (Project p : projects) { %>
                            <option value="<%= p.getProjectId() %>" <%= p.getProjectId() == plot.getProject().getProjectId() ? "selected" : "" %>>
                                <%= p.getProjectName() %>
                            </option>
                    <%  } } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Site Number</label>
                <input type="text" name="siteNumber" value="<%= plot.getSiteNumber() %>" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Size</label>
                <input type="text" name="size" value="<%= plot.getSize() %>" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Facing</label>
                <input type="text" name="facing" value="<%= plot.getFacing() %>" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Type</label>
                <select name="type" class="form-select">
                    <option value="REGULAR" <%= "REGULAR".equals(plot.getType()) ? "selected" : "" %>>Regular</option>
                    <option value="CORNER" <%= "CORNER".equals(plot.getType()) ? "selected" : "" %>>Corner</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Road Width</label>
                <input type="text" name="roadWidth" value="<%= plot.getRoadWidth() %>" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-select">
                    <option value="AVAILABLE" <%= "AVAILABLE".equals(plot.getStatus().name()) ? "selected" : "" %>>Available</option>
                    <option value="BOOKED" <%= "BOOKED".equals(plot.getStatus().name()) ? "selected" : "" %>>Booked</option>
                    <option value="SOLD" <%= "SOLD".equals(plot.getStatus().name()) ? "selected" : "" %>>Sold</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success">Update Plot</button>
        </form>
    <% } %>
</div>

</body>
</html>
