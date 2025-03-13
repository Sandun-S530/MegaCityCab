<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 50px;
            max-width: 600px;
        }
        .card {
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h2 class="text-center">User Details</h2>
        <table class="table table-bordered">
            <tr>
                <th>User ID</th>
                <td>${user.userId}</td>
            </tr>
            <tr>
                <th>Username</th>
                <td>${user.username}</td>
            </tr>
            <tr>
                <th>Full Name</th>
                <td>${user.fullName}</td>
            </tr>
            <tr>
                <th>Role</th>
                <td>${user.role}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>${user.address}</td>
            </tr>
            <tr>
                <th>NIC</th>
                <td>${user.nic}</td>
            </tr>
            <tr>
                <th>Telephone</th>
                <td>${user.telephone}</td>
            </tr>
            <c:if test="${user.role eq 'driver'}">
                <tr>
                    <th>License Number</th>
                    <td>${user.licenseNumber}</td>
                </tr>
                <tr>
                    <th>Vehicle Number</th>
                    <td>${user.vehicleNumber}</td>
                </tr>
                <tr>
                    <th>Vehicle Type</th>
                    <td>${user.vehicleType}</td>
                </tr>
            </c:if>
            <tr>
                <th>Registration Date</th>
                <td>${user.registrationDate}</td>
            </tr>
        </table>
        <div class="text-center">
            <a href="AdminDashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
