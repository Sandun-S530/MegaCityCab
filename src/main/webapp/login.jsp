<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.megacitycab.model.User" %>
<%@ page session="true" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null && sessionObj.getAttribute("user") != null) {
        User user = (User) sessionObj.getAttribute("user");
        String role = user.getRole();

        if ("customer".equals(role)) {
            response.sendRedirect("CustomerDashboardServlet");
        } else if ("driver".equals(role)) {
            response.sendRedirect("DriverDashboardServlet");
        } else if ("admin".equals(role)) {
            response.sendRedirect("AdminDashboardServlet");
        }
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mega City Cab - Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: url('images/taxi-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Arial', sans-serif;
        }
        
        .container {
            max-width: 400px;
            margin-top: 50px;
        }

        .card {
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.9);
        }

        .logo {
            width: 100px;
            display: block;
            margin: 0 auto 20px;
        }
        
        .header-text {
            text-align: center;
            color: #007bff;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .btn-custom {
            background-color: #ffcc00;
            color: black;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background-color: #ffbb00;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
        }

        .register-link {
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card text-center">
        <img src="images/mega-city-cab-logo.png" alt="Mega City Cab" class="logo">
        <h2 class="header-text">Mega City Cab Service</h2>
        
        <!-- error message if login fails -->
        <c:if test="${not empty param.error and param.error == '1'}">
            <p class="error-message">Invalid credentials. Please try again.</p>
        </c:if>

        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Username:</label>
                <input type="text" name="username" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password:</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-custom btn-lg w-100">Login</button>
            </div>
        </form>

        <p class="register-link">Don't have an account? <a href="registration.jsp">Register here</a></p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
