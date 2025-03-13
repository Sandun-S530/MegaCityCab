<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Driver Dashboard</title>
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
    </style>
</head>
<body>

<div class="container">
    <div class="card p-4">
        <!-- Header Section -->
        <div class="d-flex justify-content-between align-items-center">
            <h2 class="text-primary">Welcome, <c:out value="${sessionScope.user.fullName}"/></h2>
            <div>
            	<a href="help.jsp" class="btn btn-link me-2">Help</a>
                <a href="updateProfile.jsp" class="btn btn-secondary me-2">Update Profile</a>
                <a href="LogoutServlet" class="btn btn-danger">Logout</a>
            </div>
        </div>

        <!-- Active Bookings Section -->
        <h3 class="mt-4">Your Assigned Bookings</h3>
        <c:choose>
            <c:when test="${empty assignedBookings}">
                <p class="text-muted">You currently have no active bookings.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped mt-3">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking Number</th>
                                <th>Pickup</th>
                                <th>Destination</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${assignedBookings}">
                                <tr>
                                    <td>${booking.bookingNumber}</td>
                                    <td>${booking.pickupLocation}</td>
                                    <td>${booking.destination}</td>
                                    <td>${booking.bookingDate}</td>
                                    <td>${booking.status}</td>
                                    <td>
									    <c:if test="${booking.status == 'assigned' || booking.status == 'ongoing'}">
									        <button type="button" class="btn btn-success btn-sm" 
									                onclick="showCompletionModal(${booking.bookingId}, ${booking.estimatedBill})">
									            Mark as Completed
									        </button>									        
									    </c:if>
									</td>											
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
        
        <form id="completeForm" action="CompleteBookingServlet" method="post" style="display: none;">
		    <input type="hidden" name="bookingId" id="completeBookingId">
		</form>
        
        <!-- Completion Confirmation Modal -->
		<div class="modal fade" id="completionModal" tabindex="-1" aria-labelledby="completionModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="completionModalLabel">Confirm Completion</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <p id="billDetails"></p>
		        <p>Do you want to mark this booking as completed?</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
		        <button type="button" class="btn btn-success" onclick="submitCompletion()">Confirm</button>
		      </div>
		    </div>
		  </div>
		</div>
        

        <!-- Completed Bookings Section -->
        <h3 class="mt-5">Your Booking History</h3>
        <c:choose>
            <c:when test="${empty completedBookings}">
                <p class="text-muted">No completed bookings found.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped mt-3">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking Number</th>
                                <th>Pickup</th>
                                <th>Destination</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Bill</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${completedBookings}">
                                <tr>
                                    <td>${booking.bookingNumber}</td>
                                    <td>${booking.pickupLocation}</td>
                                    <td>${booking.destination}</td>
                                    <td>${booking.bookingDate}</td>
                                    <td>${booking.status}</td>
                                    <td>${booking.finalBill}</td>                                  
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>

    var taxRate = ${billingSettings.taxRate}; 
    var discountThreshold = ${billingSettings.discountThreshold}; 
    var discountRate = ${billingSettings.discountRate}; 

    function showCompletionModal(bookingId, estimatedBill) {

        var tax = estimatedBill * taxRate;
        var discount = (estimatedBill > discountThreshold) ? (estimatedBill * discountRate) : 0;
        var finalBill = estimatedBill + tax - discount;

        var details = "Estimated Bill: Rs. " + estimatedBill.toFixed(2) + "<br>" +
                      "Tax (" + (taxRate*100).toFixed(0) + "%): Rs. " + tax.toFixed(2) + "<br>" +
                      "Discount: Rs. " + discount.toFixed(2) + "<br>" +
                      "<strong>Final Bill: Rs. " + finalBill.toFixed(2) + "</strong>";


        document.getElementById("billDetails").innerHTML = details;
        document.getElementById("completeBookingId").value = bookingId;
        
        var completionModal = new bootstrap.Modal(document.getElementById("completionModal"));
        completionModal.show();
    }
    
    function submitCompletion() {
        document.getElementById("completeForm").submit();
    }
</script>

<script>
    (function() {
        window.history.pushState(null, "", window.location.href);
        window.onpopstate = function() {
            window.history.pushState(null, "", window.location.href);
        };
    })();
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
