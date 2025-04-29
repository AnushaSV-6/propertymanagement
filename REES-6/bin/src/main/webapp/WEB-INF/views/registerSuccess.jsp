<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Registration Successful</title>
</head>
<body>
    <h2 style="color: green;">
        <% String message = (String) request.getAttribute("message");
           if (message != null) out.print(message); 
        %>
    </h2>

    <a href="<%= request.getContextPath() %>/">Go to Login</a>
</body>
</html>
