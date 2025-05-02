<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rees.model.Customer, com.rees.model.Project, com.rees.model.Plot" %>
<html>
<head>
    <title>Add Sale</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            width: 600px;
            margin: auto;
            background-color: #fff;
            padding: 25px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        input[type=text], select, textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type=submit] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type=submit]:hover {
            background-color: #218838;
        }
        .message {
            text-align: center;
            font-weight: bold;
        }
        .message.success {
            color: green;
        }
        .message.error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Sale</h2>

        <!-- Step 1: Check customer -->
        <form method="post" action="/admin/sales/checkCustomer">
            <label>Phone Number:</label>
            <input type="text" name="phone" required />
            <input type="submit" value="Check" />
        </form>

        <% if (request.getAttribute("customer") != null) { 
            Customer customer = (Customer) request.getAttribute("customer");
        %>
            <p><strong>Customer Found:</strong> <%= customer.getName() %></p>

            <!-- Step 2: Select project -->
            <form method="post" action="/admin/sales/getPlots">
                <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>"/>
                <label>Project:</label>
                <select name="projectId">
                    <% List<Project> projects = (List<Project>) request.getAttribute("projects");
                       for (Project proj : projects) { %>
                        <option value="<%= proj.getProjectId() %>"><%= proj.getProjectName() %></option>
                    <% } %>
                </select>
                <input type="submit" value="Select Project" />
            </form>
        <% } %>

        <% if (request.getAttribute("plots") != null) { 
            int customerId = Integer.parseInt((String) request.getAttribute("customerId"));
            int projectId = (int) request.getAttribute("projectId");
        %>
            <form method="post" action="/admin/sales/submit">
                <input type="hidden" name="customerId" value="<%= customerId %>"/>
                <input type="hidden" name="projectId" value="<%= projectId %>"/>

                <label>Plot:</label>
                <select name="plotId">
                    <% List<Plot> plots = (List<Plot>) request.getAttribute("plots");
                       for (Plot plot : plots) { %>
                        <option value="<%= plot.getPlotId() %>"><%= plot.getSiteNumber() %></option>
                    <% } %>
                </select>

                <label>Amount Received:</label>
                <input type="text" name="amountReceived" required/>

                <label>Selling Price:</label>
                <input type="text" name="sellingPrice" required/>

                <label>Mode of Payment:</label>
                <select name="modeOfPayment">
                    <option value="CASH">Cash</option>
                    <option value="CHEQUE">Cheque</option>
                    <option value="DD">DD</option>
                </select>

                <label>Description:</label>
                <textarea name="description" rows="4"></textarea>

                <input type="submit" value="Submit Sale" />
            </form>
        <% } %>

        <% if (request.getAttribute("message") != null) { %>
            <p class="message success"><%= request.getAttribute("message") %></p>
        <% } else if (request.getAttribute("error") != null) { %>
            <p class="message error"><%= request.getAttribute("error") %></p>
        <% } %>
    </div>
</body>
</html>
