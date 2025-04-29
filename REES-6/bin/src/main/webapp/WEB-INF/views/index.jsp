<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rees6 - Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 350px;
        }

        h1 {
            text-align: center;
            font-size: 20px;
            margin-bottom: 10px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 18px;
            color: #333;
        }

        p {
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        form div {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .links {
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Real Estate Management</h1>
    <p>Streamline your property listings, optimize sales, and manage inventory with real-time insights.</p>

    <h2>Login to Your Account</h2>

    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
        <div class="error"><%= errorMessage %></div>
    <% } %>

    <form action="login" method="post"  onsubmit="return validateForm()">
        <div>
            <label for="email">Email:</label><br>
            <input type="text" id="email" name="email" placeholder="Enter Email" required>
        </div>
        <div>
            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" placeholder="Enter Password" required>
        </div>
        <input type="submit" value="Login">
    </form>

    <div class="links">
        <p>New User? <a href="${pageContext.request.contextPath}/register">Register Here</a></p>
        <p><a href="${pageContext.request.contextPath}/forgot">Forgot Password?</a></p>
    </div>
</div>

<script>
    function isValidEmail(email) {
        // Simple regex for basic email format validation
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailPattern.test(email);
    }

    function validateForm() {
        var email = document.getElementById("email").value.trim();
        var password = document.getElementById("password").value.trim();

        if (email === "" || password === "") {
            alert("Please fill in both fields.");
            return false;
        }

        if (!isValidEmail(email)) {
            alert("Please enter a valid email address.");
            return false;
        }

        return true;
    }
</script>


</body>
</html>
