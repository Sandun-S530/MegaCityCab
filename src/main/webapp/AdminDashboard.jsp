<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 30px;
        }
        .card {
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .icon {
            font-size: 18px;
            margin-right: 5px;
        }
    </style>

    <script>
        function confirmEdit() {
            return confirm("Are you sure you want to update this user?");
        }
        function confirmDelete() {
            return confirm("Are you sure you want to delete this user?");
        }
        (function() {
            window.history.pushState(null, "", window.location.href);
            window.onpopstate = function() {
                window.history.pushState(null, "", window.location.href);
            };
        })();
    </script>
</head>
<body>

<div class="container">
    <div class="card p-4">
        <div class="d-flex justify-content-between align-items-center">
            <h2 class="text-primary">Welcome, <c:out value="${sessionScope.user.fullName}" /></h2>
            <div>
            	<a href="help.jsp" class="btn btn-link me-2">Help</a>
                <a href="AdminReportsServlet" class="btn btn-secondary me-2">View Reports</a>
                <a href="LogoutServlet" class="btn btn-danger">Logout</a>
            </div>
        </div>
        
        <!-- Billing Settings Section -->
		<h3 class="mt-5">Billing Settings</h3>
		<c:if test="${not empty param.success and param.success eq 'billingSettings'}">
		    <p class="text-success">Billing settings updated successfully.</p>
		</c:if>
		<c:if test="${not empty param.error and param.error eq 'billingSettings'}">
		    <p class="text-danger">Failed to update billing settings.</p>
		</c:if>
		<form action="UpdateBillingSettingsServlet" method="post" class="p-3 border rounded bg-light">
		    <div class="mb-3">
		        <label class="form-label">Base Rate (Rs/KM):</label>
		        <input type="number" step="0.01" name="baseRate" value="${billingSettings.baseRate}" class="form-control" required>
		    </div>
		    <div class="mb-3">
		        <label class="form-label">Tax Rate (e.g., 0.08 for 8%):</label>
		        <input type="number" step="0.01" name="taxRate" value="${billingSettings.taxRate}" class="form-control" required>
		    </div>
		    <div class="mb-3">
		        <label class="form-label">Discount Threshold (Rs):</label>
		        <input type="number" step="0.01" name="discountThreshold" value="${billingSettings.discountThreshold}" class="form-control" required>
		    </div>
		    <div class="mb-3">
		        <label class="form-label">Discount Rate (e.g., 0.05 for 5%):</label>
		        <input type="number" step="0.01" name="discountRate" value="${billingSettings.discountRate}" class="form-control" required>
		    </div>
		    <div class="text-center">
		        <button type="submit" class="btn btn-custom btn-lg w-100">Update Billing Settings</button>
		    </div>
		</form>
		        

        <!-- Pending Bookings Section -->
        <h3 class="mt-4">Pending Bookings</h3>
        <c:choose>
            <c:when test="${empty pendingBookings}">
                <p class="text-muted">No pending bookings found.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped mt-3">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking Number</th>
                                <th>Customer ID</th>
                                <th>Pickup</th>
                                <th>Destination</th>
                                <th>Date</th>
                                <th>Vehicle Type</th>
                                <th>Assign Driver</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${pendingBookings}">
                                <tr>
                                    <td>${booking.bookingNumber}</td>
                                    <td>${booking.customerId}</td>
                                    <td>${booking.pickupLocation}</td>
                                    <td>${booking.destination}</td>
                                    <td>${booking.bookingDate}</td>
                                    <td>${booking.requiredVehicleType}</td>
                                    <td>
                                        <form action="AssignDriverServlet" method="post" class="d-inline">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                            <select name="driverId" class="form-select form-select-sm" required>
                                                <option value="">Select Driver</option>
                                                <c:forEach var="driver" items="${bookingDriversMap[booking.bookingId]}">
                                                    <option value="${driver.userId}">
                                                        ${driver.fullName} (${driver.vehicleType})
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <button type="submit" class="btn btn-success btn-sm mt-1">Assign</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
               <!-- 
               <nav aria-label="Page navigation">
		            <ul class="pagination justify-content-center">
		                <c:if test="${page > 1}">
		                    <li class="page-item">
		                        <a class="page-link" href="CustomerDashboardServlet?page=${page - 1}">Previous</a>
		                    </li>
		                </c:if>
		                <li class="page-item disabled">
		                    <a class="page-link" href="#">Page ${page} of ${totalPages}</a>
		                </li>
		                <c:if test="${page < totalPages}">
		                    <li class="page-item">
		                        <a class="page-link" href="CustomerDashboardServlet?page=${page + 1}">Next</a>
		                    </li>
		                </c:if>
		            </ul>
		        </nav>  -->
		        
            </c:otherwise>
        </c:choose>

        <!-- Booking History Section -->
        <h3 class="mt-5">Booking History</h3>
		<c:choose>
		    <c:when test="${empty bookingHistory}">
		        <p class="text-muted">No booking history found.</p>
		    </c:when>
		    <c:otherwise>
		        <div class="table-responsive">
		            <table class="table table-bordered table-striped mt-3">
		                <thead class="table-dark">
		                    <tr>
		                        <th>Booking Number</th>
		                        <th>Customer ID</th>
		                        <th>Pickup</th>
		                        <th>Destination</th>
		                        <th>Date</th>
		                        <th>Status</th>
		                        <th>Bill</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach var="booking" items="${bookingHistory}">
		                        <tr>
		                            <td>${booking.bookingNumber}</td>
		                            <td>${booking.customerId}</td>
		                            <td>${booking.pickupLocation}</td>
		                            <td>${booking.destination}</td>
		                            <td>${booking.bookingDate}</td>
		                            <td>${booking.status}</td>
		                            <td>
		                                <c:choose>
		                                    <c:when test="${not empty booking.finalBill}">
		                                        Rs. ${booking.finalBill}
		                                    </c:when>
		                                    <c:otherwise>
		                                        Rs. ${booking.estimatedBill}
		                                    </c:otherwise>
		                                </c:choose>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
		        </div>
		    </c:otherwise>
		</c:choose>


        <!-- Manage Users Section -->
        <h3 class="mt-5">Manage Users</h3>
		<c:choose>
		    <c:when test="${empty users}">
		        <p class="text-muted">No users found.</p>
		    </c:when>
		    <c:otherwise>
		        <div class="table-responsive">
		            <table class="table table-bordered table-striped mt-3">
		                <thead class="table-dark">
		                    <tr>
		                        <th>User ID</th>
		                        <th>Username</th>
		                        <th>Role</th>
		                        <th>Full Name</th>
		                        <th>Actions</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach var="user" items="${users}">
		                        <tr>
		                            <td>${user.userId}</td>
		                            <td>${user.username}</td>
		                            <td>${user.role}</td>
		                            <td>${user.fullName}</td>
		                            <td>
		                                <a href="EditUserServlet?userId=${user.userId}" class="btn btn-warning btn-sm ">Edit</a>
		                                <a href="ViewUserServlet?userId=${user.userId}" class="btn btn-info btn-sm">View Details</a>
		                                <a href="DeleteUserServlet?userId=${user.userId}" class="btn btn-danger btn-sm me-1" onclick="return confirmDelete();">Delete</a>		                                
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
		        </div>		      		        
		    </c:otherwise>
		</c:choose>
		
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function getParameterByName(name) {
        let url = new URL(window.location.href);
        return url.searchParams.get(name);
    }


    let message = getParameterByName('message');
    if (message) {
        alert(message);
        window.history.replaceState({}, document.title, window.location.pathname);
    }
</script>

<script>
    window.onload = function () {
        let message = "<%= session.getAttribute("message") %>";
        if (message && message !== "null") {
            alert(message);
            <%
                session.removeAttribute("message"); 
            %>
        }
    };
</script>



</body>
</html>
