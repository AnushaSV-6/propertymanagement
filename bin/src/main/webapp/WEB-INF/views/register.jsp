<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 320px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 12px;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-top: 6px;
            margin-bottom: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .captcha-section {
            margin-bottom: 16px;
        }

        .captcha-display {
            background-color: #e9ecef;
            padding: 10px;
            font-weight: bold;
            font-size: 18px;
            text-align: center;
            border-radius: 6px;
            margin-top: 8px;
            letter-spacing: 3px;
        }

        .alert {
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 12px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>

    <script>
        function validateCaptcha() {
            var enteredCaptcha = document.getElementById("captcha").value;
            var expectedCaptcha = document.getElementById("captcha_hidden").value;
            if (enteredCaptcha !== expectedCaptcha) {
                alert("CAPTCHA verification failed!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="form-container">
    <h2>Register</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateCaptcha()"  onsubmit="return validateForm()">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" id="email" name="email" required>

        <label>Phone:</label>
        <input type="text" name="phone" required>

        <div class="captcha-section">
            <label>Enter the code below:</label>
            <input type="text" id="captcha" name="captcha" required>
            <input type="hidden" id="captcha_hidden" name="captcha_value" value="<%= session.getAttribute("captcha_value") %>">
            <div class="captcha-display"><%= session.getAttribute("captcha_value") %></div>
        </div>

        <% if (session.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= session.getAttribute("success") %></div>
            <% session.removeAttribute("success"); %>
        <% } %>

        <button type="submit">Register</button>
    </form>
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
