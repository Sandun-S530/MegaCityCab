<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>

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
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card p-4">
        <h2 class="text-center text-primary">Edit User Information</h2>

        <!-- error message if update fails -->
        <c:if test="${not empty param.error}">
            <p class="error-message">Update failed. Please try again.</p>
        </c:if>

        <form action="EditUserServlet" method="post" onsubmit="return confirm('Are you sure you want to update this user info?');">
            <input type="hidden" name="userId" value="${user.userId}" />

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

            <div class="text-center">
                <button type="submit" class="btn btn-custom btn-lg w-100">Update User</button>
            </div>
        </form>

        <div class="text-center mt-3">
            <a href="AdminDashboardServlet" class="btn btn-secondary w-100">Back to Dashboard</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
