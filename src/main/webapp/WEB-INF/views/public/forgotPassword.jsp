<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.String" %>
<%
    String success = (String) request.getAttribute("successMessage");
    String error = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-box {
            background-color: white;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
        }

        .form-box h2 {
            margin-bottom: 25px;
            font-weight: bold;
            text-align: center;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            font-weight: 600;
            border-radius: 10px;
            margin-top: 15px;
        }

        .message {
            margin-top: 15px;
            text-align: center;
            font-weight: 500;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            text-decoration: none;
            font-weight: 500;
            color: #0d6efd;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-box">
    <h2>Forgot Password</h2>

    <form action="${pageContext.request.contextPath}/forgotPass" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Enter your email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <input type="submit" value="Send Password" class="btn btn-primary btn-submit" />
    </form>

    <% if (success != null) { %>
        <div class="message text-success"><%= success %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="message text-danger"><%= error %></div>
    <% } %>

    <div class="login-link">
        <p><a href="${pageContext.request.contextPath}/loginPage">Back to Login</a></p>
    </div>
</div>

</body>
</html>
