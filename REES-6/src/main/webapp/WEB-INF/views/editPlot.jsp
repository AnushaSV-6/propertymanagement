<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.rees.model.Project" %>
<%@ page import="com.rees.model.Plot" %>
<%@ page import="java.util.List" %>
<%
    Plot plot = (Plot) request.getAttribute("plot");
    List<Project> projects = (List<Project>) request.getAttribute("projects");
%>
<html>
<head>
    <title>Edit Plot</title>
    <style>
        body { font-family: Arial; background-color: #f9f9f9; padding: 40px; }
        form { max-width: 600px; margin: auto; background: #fff; padding: 30px; border-radius: 10px; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; }
        label { font-weight: bold; }
        button { padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #1e7e34; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Edit Plot</h2>
    <% String msg = (String) request.getAttribute("msg"); %>
<% if (msg != null) { %>
    <p style="color: green; text-align:center;"><%= msg %></p>
<% } %>
    
    <form action="/admin/plots/update" method="post">
        <input type="hidden" name="plotId" value="<%= plot.getPlotId() %>" />

        <label>Project:</label>
        <select name="project.projectId" required>
            <% for (Project p : projects) { %>
                <option value="<%= p.getProjectId() %>" <%= p.getProjectId() == plot.getProject().getProjectId() ? "selected" : "" %>>
                    <%= p.getProjectName() %>
                </option>
            <% } %>
        </select>

        <label>Site Number:</label>
        <input type="text" name="siteNumber" value="<%= plot.getSiteNumber() %>" required />

        <label>Size:</label>
        <input type="text" name="size" value="<%= plot.getSize() %>" required />

        <label>Facing:</label>
        <input type="text" name="facing" value="<%= plot.getFacing() %>" required />

        <label>Type:</label>
        <select name="type">
            <option value="REGULAR" <%= "REGULAR".equals(plot.getType()) ? "selected" : "" %>>Regular</option>
            <option value="CORNER" <%= "CORNER".equals(plot.getType()) ? "selected" : "" %>>Corner</option>
        </select>

        <label>Road Width:</label>
        <input type="text" name="roadWidth" value="<%= plot.getRoadWidth() %>" required />

        <label>Status:</label>
        <select name="status">
            <option value="AVAILABLE" <%= "AVAILABLE".equals(plot.getStatus().name()) ? "selected" : "" %>>Available</option>
            <option value="BOOKED" <%= "BOOKED".equals(plot.getStatus().name()) ? "selected" : "" %>>Booked</option>
            <option value="SALED" <%= "SALED".equals(plot.getStatus().name()) ? "selected" : "" %>>Saled</option>
        </select>

        <button type="submit">Update Plot</button>
    </form>
</body>
</html>
