<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin-top: 50px;
        }
        .card {
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function confirmUpdate() {
            return confirm("Are you sure you want to update your profile information?");
        }
    </script>
</head>
<body>

<div class="container">
    <div class="card">
        <h2 class="text-center text-primary">Update Your Profile</h2>

        <c:if test="${not empty param.error}">
            <p class="text-danger text-center">Update failed. Please try again.</p>
        </c:if>
        <form action="UpdateProfileServlet" method="post" onsubmit="return confirmUpdate();">
            <div class="mb-3">
                <label class="form-label">Username:</label>
                <input type="text" name="username" value="${user.username}" class="form-control" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name:</label>
                <input type="text" name="fullName" value="${user.fullName}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Address:</label>
                <input type="text" name="address" value="${user.address}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">NIC:</label>
                <input type="text" name="nic" value="${user.nic}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Telephone:</label>
                <input type="text" name="telephone" value="${user.telephone}" class="form-control" required>
            </div>

            <c:if test="${user.role eq 'driver'}">
                <div class="mb-3">
                    <label class="form-label">License Number:</label>
                    <input type="text" name="licenseNumber" value="${user.licenseNumber}" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Vehicle Number:</label>
                    <input type="text" name="vehicleNumber" value="${user.vehicleNumber}" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Vehicle Type:</label>
                    <select name="vehicleType" class="form-select" required>
                        <option value="">Select Vehicle Type</option>
                        <option value="Car" <c:if test="${user.vehicleType eq 'Car'}">selected</c:if>>Car</option>
                        <option value="Van" <c:if test="${user.vehicleType eq 'Van'}">selected</c:if>>Van</option>
                        <option value="SUV" <c:if test="${user.vehicleType eq 'SUV'}">selected</c:if>>SUV</option>
                        <option value="Motorbike" <c:if test="${user.vehicleType eq 'Motorbike'}">selected</c:if>>Motorbike</option>
                    </select>
                </div>
            </c:if>
            <div class="text-center">
                <button type="submit" class="btn btn-custom btn-lg w-100">Update Profile</button>
            </div>
        </form>
        <div class="text-center mt-3">
            <a href="CustomerDashboardServlet" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
