<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 30px; }
        .card { border-radius: 15px; padding: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1 class="text-primary">Reports</h1>
        
        <!-- Date Range Form -->
        <form action="AdminReportsServlet" method="get" class="mb-4">
            <div class="row">
                <div class="col-md-5">
                    <label for="startDate" class="form-label">Start Date:</label>
                    <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate}" required>
                </div>
                <div class="col-md-5">
                    <label for="endDate" class="form-label">End Date:</label>
                    <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate}" required>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">View Reports</button>
                </div>
            </div>
        </form>
        
        <h2>Booking Summary Report</h2>
        <p>Date Range: ${startDate} to ${endDate}</p>
        <table class="table table-bordered">
            <tr>
                <th>Total Bookings</th>
                <td>${bookingSummary.totalBookings}</td>
            </tr>
            <tr>
                <th>Pending Bookings</th>
                <td>${bookingSummary.pendingBookings}</td>
            </tr>
            <tr>
                <th>Completed Bookings</th>
                <td>${bookingSummary.completedBookings}</td>
            </tr>
        </table>
        
        <h2 class="mt-5">Revenue Report</h2>
        <p>Date Range: ${startDate} to ${endDate}</p>
        <table class="table table-bordered">
            <tr>
                <th>Total Revenue</th>
                <td>Rs. <fmt:formatNumber value="${revenueReport.totalRevenue}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
            <tr>
                <th>Average Revenue per Booking</th>
                <td>Rs. <fmt:formatNumber value="${revenueReport.averageRevenue}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
        </table>
        
        <div class="mt-4">
            <a href="AdminDashboardServlet" class="btn btn-secondary">Return to Dashboard</a>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
