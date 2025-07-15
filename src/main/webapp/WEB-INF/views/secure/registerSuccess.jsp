<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-box {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0px 6px 18px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 450px;
            width: 100%;
        }

        .card-box h2 {
            color: #28a745;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .btn-login {
            margin-top: 20px;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 10px;
        }

        a.btn-login:hover {
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="card-box">
    <h2>
        <% String message = (String) request.getAttribute("message");
           if (message != null) out.print(message); 
        %>
    </h2>

	<p><a href="${pageContext.request.contextPath}/loginPage"> Back to Login</a></p>
</div>

</body>
</html>
