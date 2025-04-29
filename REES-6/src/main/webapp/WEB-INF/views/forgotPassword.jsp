<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <h2>Forgot Password</h2>

    <!-- Form to enter email -->
    <form action="${pageContext.request.contextPath}/forgot" method="post">
        <label>Email:</label>
        <input type="email" name="email" required />
        <input type="submit" value="Send Password" />
    </form>

    <!-- Success and error messages -->
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>

    <% if (successMessage != null) { %>
        <div style="color: green;"><%= successMessage %></div>
    <% } %>

    <% if (errorMessage != null) { %>
        <div style="color: red;"><%= errorMessage %></div>
    <% } %>

    <p><a href="${pageContext.request.contextPath}/index">Login here</a></p>
</body>
</html>
