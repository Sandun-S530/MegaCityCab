<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mega City Cab - Register</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: url('images/taxi-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Arial', sans-serif;
        }
        
        .container {
            max-width: 500px;
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

        #driverFields {
            display: none;
        }
    </style>

    <script>
        function showDriverFields() {
            var role = document.getElementById("role").value;
            document.getElementById("driverFields").style.display = (role === "driver") ? "block" : "none";
        }

        function validateForm() {
            var username = document.getElementsByName("username")[0].value;
            var password = document.getElementsByName("password")[0].value;
            var fullName = document.getElementsByName("fullName")[0].value;
            var nic = document.getElementsByName("nic")[0].value;
            var telephone = document.getElementsByName("telephone")[0].value;
            var licenseNumber = document.getElementsByName("licenseNumber")[0].value;
            var vehicleNumber = document.getElementsByName("vehicleNumber")[0].value;
            var role = document.getElementById("role").value;

            var usernameRegex = /^[a-zA-Z][a-zA-Z0-9]{3,15}$/;
            if (!username.match(usernameRegex)) {
                alert("Username must contain letters and numbers (4-16 characters), and not only numbers.");
                return false;
            }

            var passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
            if (!password.match(passwordRegex)) {
                alert("Password must be at least 8 characters and include letters and numbers.");
                return false;
            }

            var fullNameRegex = /^[A-Za-z ]{3,50}$/;
            if (!fullName.match(fullNameRegex)) {
                alert("Full Name must only contain letters (3-50 characters).");
                return false;
            }

            var nicRegex = /^\d{9}v$|^\d{12}$/;
            if (!nic.match(nicRegex)) {
                alert("NIC must be 12 digits or 9 digits followed by 'v'.");
                return false;
            }

            var telephoneRegex = /^\d{10}$/;
            if (!telephone.match(telephoneRegex)) {
                alert("Telephone must be exactly 10 digits.");
                return false;
            }

            var licenseRegex = /^LIC\d{5}$/;
            if (role === "driver" && !licenseNumber.match(licenseRegex)) {
                alert("License Number must start with 'LIC' followed by 5 digits.");
                return false;
            }

            var vehicleRegex = /^VH\d{4}$/;
            if (role === "driver" && !vehicleNumber.match(vehicleRegex)) {
                alert("Vehicle Number must start with 'VH' followed by 4 digits.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>

<div class="container">
    <div class="card">
        <img src="images/mega-city-cab-logo.png" alt="Mega City Cab" class="logo">
        <h2 class="header-text">Create New Account</h2>

        <c:if test="${not empty param.error and param.error == '1'}">
            <p class="error-message">Registration failed. Please try again.</p>
        </c:if>

        <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <div class="mb-3">
                <label class="form-label">Username:</label>
                <input type="text" name="username" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password:</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Full Name:</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Address:</label>
                <input type="text" name="address" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">NIC:</label>
                <input type="text" name="nic" class="form-control" placeholder="e.g., 111111111111 / 111111111v" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Telephone:</label>
                <input type="text" name="telephone" class="form-control" placeholder="e.g., 0712223333 " required>
            </div>

            <div class="mb-3">
                <label class="form-label">Role:</label>
                <select name="role" id="role" class="form-select" onchange="showDriverFields()">
                    <option value="customer">Customer</option>
                    <option value="driver">Driver</option>
                </select>
            </div>
          
            <div id="driverFields">
                <div class="mb-3">
                    <label class="form-label">License Number:</label>
                    <input type="text" name="licenseNumber" class="form-control" placeholder="e.g., LIC12345">
                </div>

                <div class="mb-3">
                    <label class="form-label">Vehicle Number:</label>
                    <input type="text" name="vehicleNumber" class="form-control" placeholder="e.g., VH1234">
                </div>

                <div class="mb-3">
                    <label class="form-label">Vehicle Type:</label>
                    <select name="vehicleType" class="form-select">
                        <option value="">Select a vehicle type</option>
                        <option value="Car">Car</option>
                        <option value="Van">Van</option>
                        <option value="SUV">SUV</option>
                        <option value="Motorbike">Motorbike</option>
                    </select>
                </div>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-custom btn-lg w-100">Register</button>
            </div>
        </form>

        <p class="register-link">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
