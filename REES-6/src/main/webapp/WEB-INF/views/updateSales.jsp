<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rees.model.Customer, com.rees.model.Project, com.rees.model.Plot, com.rees.model.Sales" %>
<%
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    Customer customer = (Customer) request.getAttribute("customer");
    java.util.List<Project> projects = (java.util.List<Project>) request.getAttribute("projects");
    java.util.List<Plot> plots = (java.util.List<Plot>) request.getAttribute("plots");
    Sales sale = (Sales) request.getAttribute("sale");
    Boolean installmentsRemaining = (Boolean) request.getAttribute("installmentsRemaining");

    String selectedProjectId = request.getAttribute("selectedProjectId") != null ? request.getAttribute("selectedProjectId").toString() : null;
    String selectedPlotId = request.getAttribute("selectedPlotId") != null ? request.getAttribute("selectedPlotId").toString() : null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Sale</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: "Poppins", sans-serif;
            padding-top: 60px;
        }
        .container {
            max-width: 700px;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h3, h4 {
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/admin/sales" class="btn btn-secondary mb-3">&larr; Back to Manage Sales</a>
    <h3>Update Existing Sale</h3>

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } else if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>

    <!-- Step 1: Search Customer -->
    <form method="post" action="update" class="mb-4">
        <div class="mb-3">
            <label class="form-label">Customer Phone</label>
            <input type="text" name="phone" class="form-control" required value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>"/>
        </div>
        <button type="submit" class="btn btn-primary">Find Customer</button>
    </form>

    <% if (customer != null) { %>
        <p><strong>Customer:</strong> <%= customer.getName() %></p>

        <% if (projects != null && !projects.isEmpty()) { %>
            <!-- Step 2: Select Project -->
            <form method="post" action="update" class="mb-4">
                <input type="hidden" name="phone" value="<%= customer.getContactNumber() %>"/>
                <div class="mb-3">
                    <label class="form-label">Select Project</label>
                    <select name="projectId" class="form-select" required>
                        <option value="">--Select Project--</option>
                        <% for (Project p : projects) { %>
                            <option value="<%= p.getProjectId() %>" <%= (selectedProjectId != null && selectedProjectId.equals(String.valueOf(p.getProjectId()))) ? "selected" : "" %>>
                                <%= p.getProjectName() %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Show Plots</button>
            </form>
        <% } else { %>
            <div class="alert alert-info">No sales found for this customer.</div>
        <% } %>
    <% } %>

    <% if (customer != null && selectedProjectId != null && plots != null && !plots.isEmpty()) { %>
        <!-- Step 3: Select Plot -->
        <form method="post" action="update" class="mb-4">
            <input type="hidden" name="phone" value="<%= customer.getContactNumber() %>"/>
            <input type="hidden" name="projectId" value="<%= selectedProjectId %>"/>
            <div class="mb-3">
                <label class="form-label">Select Plot</label>
                <select name="plotId" class="form-select" required>
                    <option value="">--Select Plot--</option>
                    <% for (Plot p : plots) { %>
                        <option value="<%= p.getPlotId() %>" <%= (selectedPlotId != null && selectedPlotId.equals(String.valueOf(p.getPlotId()))) ? "selected" : "" %>>
                            <%= p.getSiteNumber() %> - <%= p.getStatus() %>
                        </option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Load Sale</button>
        </form>
    <% } %>

    <% if (sale != null) { %>
        <hr/>
        <h4>Sale Summary</h4>
        <p><strong>Selling Price:</strong> ₹<%= sale.getSellingPrice() %></p>
        <p><strong>Amount Received:</strong> ₹<%= sale.getAmountReceived() %></p>
        <p><strong>Remaining:</strong> ₹<%= sale.getSellingPrice() - sale.getAmountReceived() %></p>

        <% if (installmentsRemaining != null && installmentsRemaining) { %>
            <h4 class="mt-4">Add Installment</h4>
            <form method="post" action="addInstallment">
                <input type="hidden" name="saleId" value="<%= sale.getSalesId() %>"/>
                <div class="mb-3">
                    <label class="form-label">Amount</label>
                    <input type="number" step="0.01" name="amountReceived" class="form-control" required/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Date of Payment</label>
                    <input type="date" name="paymentDate" class="form-control" required/>
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
                <button type="submit" class="btn btn-success">Add Payment</button>
            </form>
        <% } else { %>
            <div class="alert alert-success"><strong>This sale is fully paid. Plot is SOLD.</strong></div>
        <% } %>
    <% } %>
</div>
</body>
</html>
