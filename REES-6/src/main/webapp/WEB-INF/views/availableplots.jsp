<%@ page import="java.util.List, com.rees.model.Plot" %>



<%@ page import="java.util.List, com.rees.model.Plot" %>
<%
    String projectId = (String) request.getAttribute("projectId");
    String selectedStatus = (String) request.getAttribute("selectedStatus");
    String projectName = (String) request.getAttribute("projectName");
    String surveyNum = (String) request.getAttribute("surveyNum");
    String village = (String) request.getAttribute("village");
    List<Plot> plots = (List<Plot>) request.getAttribute("plots");
    //String pdf_path = (String) request.getAttribute("pdf_path");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Available Plots</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/plot.css">
   
</head>
<body>
    <div class="container">
        <h2>Available Plots</h2>
        <div class="filter-container">
            <form action="availableplots" method="post">
                <label>Filter by Status:</label>
                <input type="radio" name="status" value="All" <%= "All".equals(selectedStatus) ? "checked" : "" %> onclick="this.form.submit()"> All
                <input type="radio" name="status" value="Available" <%= "Available".equals(selectedStatus) ? "checked" : "" %> onclick="this.form.submit()"> Available
                <input type="radio" name="status" value="Booked" <%= "Booked".equals(selectedStatus) ? "checked" : "" %> onclick="this.form.submit()"> Booked
                <input type="radio" name="status" value="Registered" <%= "Registered".equals(selectedStatus) ? "checked" : "" %> onclick="this.form.submit()"> Registered
                <input type="hidden" name="projectId" value="<%= projectId %>">
            </form>
        </div>

        <table>
            <tr>
                <th>Site No</th>
                <th>Pname</th>
                <th>Facility</th>
                <th>Plot Type</th>
                <th>Status</th>
            </tr>
            <% for (Plot plot : plots) { %>
                <tr>
                    <td><%= plot.getSiteNo() %></td>
                    <td><%= plot.getPname() %></td>
                    <td><%= plot.getFacility() %></td>
                    <td><%= plot.getPlotType() %></td>
                    <td><%= plot.getStatus() %></td>
                </tr>
            <% } %>
        </table>
    </div>
    
    <% if (projectName != null && surveyNum != null && village != null) { %>
        <div class="project-info">
            <p><strong>Project:</strong> <%= projectName %></p>
            <p><strong>Survey No:</strong> <%= surveyNum %></p>
            <p><strong>Village:</strong> <%= village %></p>
        </div>
    <% } %>

    
</body>
</html>