<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: url('${pageContext.request.contextPath}/assets/img/floor-plan.jpg') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Poppins', sans-serif;
    }

    .register-box {
      background-color: rgba(255, 255, 255, 0.95);
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
      width: 700px;
    }

    .back-button {
      position: absolute;
      top: 20px;
      left: 20px;
      font-size: 18px;
      color: #007bff;
      text-decoration: none;
    }

    .back-button:hover {
      text-decoration: underline;
    }

    .form-label {
      font-weight: 600;
    }

    .captcha-display {
      background-color: #e9ecef;
      font-size: 18px;
      font-weight: bold;
      letter-spacing: 3px;
      text-align: center;
      padding: 8px;
      border-radius: 6px;
      margin-top: 6px;
    }

    .alert {
      margin-top: 10px;
    }
  </style>
</head>
<body>

<a href="${pageContext.request.contextPath}/login" style="position: fixed; top: 20px; left: 20px; z-index: 1000; background: white; padding: 10px 15px; border-radius: 12px; box-shadow: 0 2px 6px rgba(0,0,0,0.2); text-decoration: none; color: black; display: flex; align-items: center;">
   <img src="${pageContext.request.contextPath}/assets/img/backbutton.png" alt="Back" style="height: 20px; margin-right: 8px;"></a>
   
<div class="d-flex align-items-center justify-content-center vh-100">
  <div class="register-box">
    <h2 class="text-center mb-4">Create Your Account</h2>

    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger text-center"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (session.getAttribute("success") != null) { %>
      <div class="alert alert-success text-center"><%= session.getAttribute("success") %></div>
      <% session.removeAttribute("success"); %>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateFormAndCaptcha();">
      <div class="row mb-3">
        <div class="col-md-6">
          <label class="form-label">Name</label>
          <input type="text" name="name" class="form-control" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">Email</label>
          <input type="email" name="email" id="email" class="form-control" required>
        </div>
      </div>

      <div class="row mb-3">
        <div class="col-md-6">
          <label class="form-label">Phone</label>
          <input type="text" name="phone" id="phone" class="form-control" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">Enter CAPTCHA</label>
          <input type="text" id="captcha" name="captcha" class="form-control" required>
          <input type="hidden" id="captcha_hidden" name="captcha_value" value="<%= session.getAttribute("captcha_value") %>">
          <div class="captcha-display"><%= session.getAttribute("captcha_value") %></div>
        </div>
      </div>

      <div class="d-grid mt-3">
        <button type="submit" class="btn btn-primary">Register</button>
      </div>
    </form>
  </div>
</div>

<script>
  function isValidEmail(email) {
    var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return pattern.test(email);
  }

  function isValidPhone(phone) {
    return /^[6-9]\d{9}$/.test(phone);
  }

  function validateFormAndCaptcha() {
    var email = document.getElementById("email").value.trim();
    var phone = document.getElementById("phone").value.trim();
    var captcha = document.getElementById("captcha").value.trim();
    var expectedCaptcha = document.getElementById("captcha_hidden").value;

    if (!isValidEmail(email)) {
      alert("Enter a valid email address.");
      return false;
    }

    if (!isValidPhone(phone)) {
      alert("Enter a valid 10-digit phone number.");
      return false;
    }

    if (captcha !== expectedCaptcha) {
      alert("CAPTCHA verification failed!");
      return false;
    }

    return true;
  }
</script>

</body>
</html>
