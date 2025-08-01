<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.rees.model.Project"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Project</title>
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
            background: #f8f9fa;
            padding-top: 60px;
            font-family: "Poppins", sans-serif;
        }

        .container {
            max-width: 900px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.15);
        }

        h3 {
            margin-bottom: 30px;
            font-weight: 600;
        }

        .form-label {
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 10px;
        }

        .btn-primary {
            border-radius: 10px;
            padding: 10px 30px;
            font-weight: 500;
        }

       
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/rees/admin/projects" 		class="back-button">
		    <i class="bi bi-arrow-left"></i> Back
        </a>

        <h3>Add New Project</h3>

        <% 
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");

            if (message != null) {
        %>
        <div class="alert alert-success"><%= message %></div>
        <% } else if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/rees/admin/projects/save" method="post">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Project Name</label>
                    <input type="text" name="projectName" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Survey Number</label>
                    <input type="text" name="surveyNumber" class="form-control" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Location</label>
                    <input type="text" name="location" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Total Area</label>
                    <input type="text" name="totalArea" class="form-control" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Saleable Area</label>
                    <input type="text" name="saleableArea" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Project Type</label>
                    <select name="projectType" class="form-select" required>
                        <option value="OWN">OWN</option>
                        <option value="JV">JV</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Project Status</label>
                    <select name="projectStatus" class="form-select" required>
						    <option value="STARTED">STARTED</option>
						    <option value="COMPLETED">COMPLETED</option>
						    <option value="JV">JV</option>
						    <option value="PURCHASED">PURCHASED</option>
						    <option value="REGISTERED">REGISTERED</option>
						    <option value="UNDERAGREEMENT">UNDERAGREEMENT</option>

                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Map PDF Path</label>
                    <input type="text" name="mapPdf" class="form-control">
                </div>
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-primary">Save Project</button>
            </div>
        </form>
    </div>
</body>
</html>
