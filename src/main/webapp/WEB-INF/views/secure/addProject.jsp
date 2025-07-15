<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.rees.model.Project"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Project</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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

        .back-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background: white;
            padding: 10px 15px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
            text-decoration: none;
            color: black;
            display: flex;
            align-items: center;
        }

        .back-btn img {
            height: 20px;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/rees/admin/projects" class="back-btn">
            <img src="${pageContext.request.contextPath}/images/backbutton.png" alt="Back">
            <span>Back</span>
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
                        <option value="REGISTERED">REGISTERED</option>
                        <option value="COMPLETED">COMPLETED</option>
                        <option value="PURCHASED">PURCHASED</option>
                        <option value="UNDERAGREEMENT">UNDER AGREEMENT</option>
                        <option value="JV">JV</option>
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
