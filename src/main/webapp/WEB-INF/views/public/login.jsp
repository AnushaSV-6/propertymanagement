<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>REES - Login</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet" />

    <style>
        body {
            font-family: 'Nunito', 'Varela Round', sans-serif;
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-card {
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 6px 24px rgba(0, 0, 0, 0.1);
            padding: 40px 30px;
            width: 100%;
            max-width: 400px;
        }
        .login-card h1 { font-size: 24px; font-weight: 800; margin-bottom: 10px; }
        .login-card p { color: #6c757d; font-size: 14px; }
        .form-control { border-radius: 0.5rem; }
        .btn-primary { border-radius: 0.5rem; }
        .error { color: red; text-align: center; margin-bottom: 15px; }
        .links a { font-size: 14px; color: #007bff; text-decoration: none; }
        .links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
	<div class="login-card">
	    <h1 class="text-center">REES Login</h1>
	    <p class="text-center">Secure access to your real estate management portal.</p>

	    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	    <% if (errorMessage != null) { %>
	        <div class="error"><%= errorMessage %></div>
	    <% } %>

	    <form action="${pageContext.request.contextPath}/rees/login" method="post" onsubmit="return validateForm()">
	        <div class="mb-3">
	            <label for="email" class="form-label">Email:</label>
	            <input type="text" class="form-control" id="email" name="email" placeholder="Enter Email" required>
	        </div>

	        <div class="mb-3">
	            <label for="password" class="form-label">Password:</label>
	            <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
	        </div>

	        <button type="submit" class="btn btn-primary w-100">Login</button>
	    </form>

	    <div class="text-center mt-3 links">
	        <p>New User? <a href="${pageContext.request.contextPath}/rees/register">Register Here</a></p>
	        <p><a href="${pageContext.request.contextPath}/rees/forgot">Forgot Password?</a></p>
	    </div>
	</div>

	<script>
	    function isValidEmail(email) {
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
