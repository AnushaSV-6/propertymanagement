<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.dto.PlotDTO" %>
<%@ page import="com.rees.dto.ProjectDTO" %>
<%
    List<ProjectDTO> projects = (List<ProjectDTO>) request.getAttribute("projects");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    PlotDTO plot = (PlotDTO) request.getAttribute("plot");
    if (plot == null) plot = new PlotDTO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Plot</title>
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
        .btn-primary {
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
    <a href="${pageContext.request.contextPath}/rees/admin/plots"	class="back-button">
			    <i class="bi bi-arrow-left"></i> Back
    </a>
    <h3>Add New Plot</h3>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/rees/admin/plots/add" method="post">
        <div class="mb-3">
            <label class="form-label">Select Project</label>
            <select name="projectId" class="form-select" required>
                <option value="">-- Select Project --</option>
                <% if (projects != null) {
                    for (ProjectDTO p : projects) { %>
                        <option value="<%= p.getProjectId() %>" <%= p.getProjectId() != null && p.getProjectId().equals(plot.getProjectId()) ? "selected" : "" %>><%= p.getProjectName() %></option>
                <%  } } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Site Number</label>
            <input type="text" name="siteNumber" class="form-control" required value="<%= plot.getSiteNumber() != null ? plot.getSiteNumber() : "" %>" />
        </div>

        <div class="mb-3">
            <label class="form-label">Size</label>
            <input type="text" name="size" class="form-control" required value="<%= plot.getSize() != null ? plot.getSize() : "" %>" />
        </div>

        <div class="mb-3">
            <label class="form-label">Facing</label>
            <input type="text" name="facing" class="form-control" required value="<%= plot.getFacing() != null ? plot.getFacing() : "" %>" />
        </div>

        <div class="mb-3">
            <label class="form-label">Type</label>
            <select name="type" class="form-select" required>
                <option value="REGULAR" <%= "REGULAR".equalsIgnoreCase(plot.getType()) ? "selected" : "" %>>Regular</option>
                <option value="CORNER" <%= "CORNER".equalsIgnoreCase(plot.getType()) ? "selected" : "" %>>Corner</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Road Width</label>
            <input type="text" name="roadWidth" class="form-control" required value="<%= plot.getRoadWidth() != null ? plot.getRoadWidth() : "" %>" />
        </div>

       

        <button type="submit" class="btn btn-primary">Save Plot</button>
    </form>
</div>

</body>
</html>
