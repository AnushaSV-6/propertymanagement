<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rees.model.Customer, com.rees.model.Project, com.rees.model.Plot" %>
<%
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    Customer customer = (Customer) request.getAttribute("customer");
    java.util.List<Project> projects = (java.util.List<Project>) request.getAttribute("projects");
    java.util.List<Plot> plots = (java.util.List<Plot>) request.getAttribute("plots");
    Boolean saleExists = (Boolean) request.getAttribute("saleExists");
    Project selectedProject = (Project) request.getAttribute("selectedProject");
    Plot selectedPlot = (Plot) request.getAttribute("selectedPlot");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Sale</title>
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
			    }        body {
            background: #f8f9fa;
            padding-top: 60px;
            font-family: "Poppins", sans-serif;
        }
        .container {
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h3 {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/rees/admin/sales" 	class="back-button">
			    <i class="bi bi-arrow-left"></i> Back
	</a>>

    <h3>Add Sale - Step by Step</h3>

    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } else if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <!-- Step 1: Search Customer -->
    <form action="${pageContext.request.contextPath}/rees/admin/sales/checkCustomer" method="post" class="mb-4">
        <div class="mb-3">
            <label class="form-label">Customer Phone</label>
            <input type="text" name="phone" class="form-control" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>" required />
        </div>
        <button type="submit" class="btn btn-primary">Find Customer</button>
    </form>

    <% if (customer != null) { %>
        <p><strong>Customer Found:</strong> <%= customer.getName() %></p>

        <!-- Step 2: Select Project -->
        <form action="${pageContext.request.contextPath}/rees/admin/sales/getPlots" method="post" class="mb-4">
            <input type="hidden" name="phone" value="<%= customer.getContactNumber() %>" />
            <div class="mb-3">
                <label class="form-label">Select Project</label>
                <select name="projectId" class="form-select" required>
                    <option value="">--Select--</option>
                    <% if (projects != null) {
                        for (Project p : projects) { %>
                            <option value="<%= p.getProjectId() %>" <%= (selectedProject != null && selectedProject.getProjectId() == p.getProjectId()) ? "selected" : "" %>>
                                <%= p.getProjectName() %>
                            </option>
                    <% }} %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Select Project</button>
        </form>
    <% } %>

    <% if (customer != null && selectedProject != null && plots != null) { %>
        <!-- Step 3: Select Plot -->
        <form action="${pageContext.request.contextPath}/rees/admin/sales/checkSale" method="post" class="mb-4">
            <input type="hidden" name="phone" value="<%= customer.getContactNumber() %>" />
            <input type="hidden" name="projectId" value="<%= selectedProject.getProjectId() %>" />
            <div class="mb-3">
                <label class="form-label">Select Plot</label>
                <select name="plotId" class="form-select" required>
                    <option value="">--Select--</option>
                    <% for (Plot p : plots) { %>
                        <option value="<%= p.getPlotId() %>" <%= (selectedPlot != null && selectedPlot.getPlotId() == p.getPlotId()) ? "selected" : "" %>>
                            <%= p.getSiteNumber() %> - <%= p.getStatus() %>
                        </option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Check Sale</button>
        </form>
    <% } %>

    <% if (saleExists != null && saleExists) { %>
        <div class="alert alert-info">Sale already exists for this customer.</div>
        <form method="get" action="${pageContext.request.contextPath}/rees/admin/sales/updateSales">
            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>" />
            <input type="hidden" name="projectId" value="<%= selectedProject.getProjectId() %>" />
            <input type="hidden" name="plotId" value="<%= selectedPlot.getPlotId() %>" />
            <button type="submit" class="btn btn-warning">Go to Update Sale</button>
        </form>
    <% } %>

    <% if (customer != null && selectedProject != null && selectedPlot != null && (saleExists == null || !saleExists)) { %>
        <!-- Step 4: Enter Sale Details -->
        <form method="post" action="${pageContext.request.contextPath}/rees/admin/sales/submit">
            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>" />
            <input type="hidden" name="projectId" value="<%= selectedProject.getProjectId() %>" />
            <input type="hidden" name="plotId" value="<%= selectedPlot.getPlotId() %>" />

            <div class="mb-3">
                <label class="form-label">Selling Price</label>
                <input type="number" name="sellingPrice" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Amount Received</label>
                <input type="number" name="amountReceived" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Date of Payment</label>
                <input type="date" name="paymentDate" class="form-control" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Mode of Payment</label>
                <select name="modeOfPayment" class="form-select" required>
                    <option value="CASH">Cash</option>
                    <option value="CHEQUE">Cheque</option>
                    <option value="DD">DD</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-success">Add Sale</button>
        </form>
    <% } %>
</div>
</body>
</html>
