<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Plots</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f2f2f2;
	padding: 50px;
}

.container {
	max-width: 600px;
	background-color: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
	text-align: center;
}

h2 {
	margin-bottom: 30px;
}

.btn-option {
	width: 100%;
	margin: 10px 0;
	padding: 15px;
	font-size: 18px;
	font-weight: bold;
	border-radius: 8px;
}

.btn-option:hover {
	transform: scale(1.02);
}
</style>
</head>
<body>

	<div class="container">
		<h2>Manage Plots</h2>

		<a href="<%= request.getContextPath() %>/admin/plots/add"
			class="btn btn-primary btn-option">Add Plot</a> <a
			href="<%= request.getContextPath() %>/admin/plots/edit"
			class="btn btn-warning btn-option">Update Plot</a> <a
			href="<%= request.getContextPath() %>/admin/plots/list"
			class="btn btn-success btn-option">View Plots</a>
	</div>

</body>
</html>
