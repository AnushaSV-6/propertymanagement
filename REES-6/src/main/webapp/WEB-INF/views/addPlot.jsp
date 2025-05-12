<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.Project" %>
<%@ page import="com.rees.model.Plot" %>
<%
    List<Project> projects = (List<Project>) request.getAttribute("projects");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>Add Plot</title>
<style>
        body { font-family: Arial; background-color: #f9f9f9; padding: 40px; }
        form { max-width: 600px; margin: auto; background: #fff; padding: 30px; border-radius: 10px; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; }
        label { font-weight: bold; }
        button { padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
    </style>
</head>
<body>
	<div class="container">
		<h3>Add New Plot</h3>

		<%-- Displaying the message if present --%>
		<% if (message != null) { %>
		<div class="alert alert-success" role="alert">
			<%= message %>
		</div>
		<% } %>

		<%-- Displaying the error message if present --%>
		<% if (error != null) { %>
		<div class="alert alert-danger" role="alert">
			<%= error %>
		</div>
		<% } %>

<form action="${pageContext.request.contextPath}/admin/plots/add"
			method="post">
	        <select name="project.projectId" required>
	            <% for (Project p : projects) { %>
	                <option value="<%= p.getProjectId() %>"><%= p.getProjectName() %></option>
	            <% } %>
	        </select>

	        <label>Site Number:</label>
	        <input type="text" name="siteNumber" required />

	        <label>Size:</label>
	        <input type="text" name="size" required />

	        <label>Facing:</label>
	        <input type="text" name="facing" required />

	        <label>Type:</label>
	        <select name="type" required>
	            <option value="REGULAR">Regular</option>
	            <option value="CORNER">Corner</option>
	        </select>

	        <label>Road Width:</label>
	        <input type="text" name="roadWidth" required />

	        <button type="submit">Save Plot</button>
	    </form>
	</div>
</body>
</html>
