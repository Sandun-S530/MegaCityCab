<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>

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
        <div class="d-flex justify-content-between align-items-center">
            <h2 class="text-primary">Welcome, <c:out value="${sessionScope.user.fullName}"/></h2>
            <div>               
                <a href="help.jsp" class="btn btn-link me-2">Help</a>
                <a href="EditProfileServlet" class="btn btn-secondary me-2">Update Profile</a>
                <a href="LogoutServlet" class="btn btn-danger">Logout</a>
            </div>
        </div>
      		
		<div class="container">
		    <div class="card p-4">
		        <h3 class="mt-4">Create a New Booking</h3>
		        <!-- Booking Form -->
		        <form action="BookingServlet" method="post" class="p-3 border rounded bg-light" id="bookingForm">
		            <div class="mb-3">
		                <label class="form-label">Pickup Location:</label>
		                <input type="text" name="pickup" class="form-control" required>
		            </div>
		        
		            <div class="mb-3">
		                <label class="form-label">Destination:</label>
		                <input type="text" name="destination" class="form-control" required>
		            </div>
		        		            
		            <div class="mb-3">
		                <label class="form-label">Pickup Date:</label>
		                <input type="date" name="bookingDate" id="bookingDate" class="form-control" required>
		            </div>
		        
		            <div class="mb-3">
		                <label class="form-label">Pickup Time:</label>
		                <input type="time" name="bookingTime" id="bookingTime" class="form-control" required>
		            </div>
		        
		            <div class="mb-3">
		                <label class="form-label">Required Vehicle Type:</label>
		                <select name="vehicleType" class="form-select" required>
		                    <option value="">Select Vehicle Type</option>
		                    <option value="Car">Car</option>
		                    <option value="Van">Van</option>
		                    <option value="SUV">SUV</option>
		                    <option value="Motorbike">Motorbike</option>
		                </select>
		            </div>
		        
		            <div class="mb-3">
		                <label class="form-label">Trip Distance (KM):</label>
		                <input type="number" step="0.01" name="tripKm" class="form-control" required>
		            </div>
		        
		            <div class="text-center">
		                <button type="button" class="btn btn-custom btn-lg w-100" id="submitBooking">Submit Booking</button>
		            </div>
		        </form>
		    </div>
		</div>
		
		
		<!-- Booking Confirmation Modal -->
		<div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="bookingModalLabel">Confirm Your Booking</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <div id="billDetails">

		        </div>
		        <p>Do you want to confirm this booking?</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
		        <button type="button" class="btn btn-success" onclick="submitBookingForm()">Confirm Booking</button>
		      </div>
		    </div>
		  </div>
		</div>
			
        <!-- Booking Listing Section -->
		<h3 class="mt-5">Your Bookings</h3>
		<c:choose>
		    <c:when test="${empty bookings}">
		        <p class="text-muted">No bookings found.</p>
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
		                        <th>Vehicle Type</th>                       
		                        <th>Distance</th>		                       
		                        <th>Estimated Bill</th>
		                        <th>Status</th>		
		                        <th>Final Bill</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach var="booking" items="${bookings}">
		                        <tr>
		                            <td>${booking.bookingNumber}</td>
		                            <td>${booking.pickupLocation}</td>
		                            <td>${booking.destination}</td>
		                            <td>${booking.bookingDate}</td>
		                            <td>${booking.requiredVehicleType}</td>		                            
		                            <td>${booking.tripKm}</td>
		                            <td>${booking.estimatedBill}</td>
		                            <td>${booking.status}</td>
		                            <td>${booking.finalBill}</td>			                            	                            
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
		        </div>
		        
		        <!-- Pagination Controls -->
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
		        </nav>
		        
		    </c:otherwise>
		</c:choose>
	</div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

		<script>
		    document.getElementById("submitBooking").addEventListener("click", function(event) {
		        const bookingDate = document.getElementById("bookingDate").value;
		        const bookingTime = document.getElementById("bookingTime").value;
		        const now = new Date();
		
		        if (!bookingDate || !bookingTime) {
		            alert("Please select a valid date and time.");
		            event.preventDefault();
		            return;
		        }
		
		        const selectedDateTime = new Date(bookingDate + "T" + bookingTime);
		        
		        if (selectedDateTime < now) {
		            alert("You cannot select a past date or time. Please choose a future time.");
		            event.preventDefault();
		            return;
		        }
		    });
		</script>

<!-- Billing Calculation Script -->
<script>

    var baseRate = ${billingSettings.baseRate};           
    var taxRate = ${billingSettings.taxRate};               
    var discountThreshold = ${billingSettings.discountThreshold}; 
    var discountRate = ${billingSettings.discountRate};     
    

    document.getElementById("submitBooking").addEventListener("click", function(event) {
        var tripKm = parseFloat(document.getElementsByName("tripKm")[0].value);
        if (isNaN(tripKm) || tripKm <= 0) {
            alert("Please enter a valid trip distance.");
            return;
        }
        
        var estimatedBill = tripKm * baseRate;
        var tax = estimatedBill * taxRate;
        var discount = (estimatedBill > discountThreshold) ? (estimatedBill * discountRate) : 0;
        var finalBill = estimatedBill + tax - discount;
        
        var details = "<strong>Estimated Bill:</strong> Rs. " + estimatedBill.toFixed(2) + "<br>" +
                      "<strong>Tax (" + (taxRate * 100).toFixed(0) + "%):</strong> Rs. " + tax.toFixed(2) + "<br>" +
                      "<strong>Discount:</strong> Rs. " + discount.toFixed(2) + "<br>" +
                      "<strong>Final Bill:</strong> Rs. " + finalBill.toFixed(2);
        
        document.getElementById("billDetails").innerHTML = details;
        
        var bookingModal = new bootstrap.Modal(document.getElementById("bookingModal"));
        bookingModal.show();
    });

    function submitBookingForm() {
        document.getElementById("bookingForm").submit();
    }
</script>

<c:if test="${param.success == 'bookingCreated'}">
  <script>
    alert("Booking created successfully!");
    // Remove the 'success' msg from the URL without reloading the page.
    if(window.history.replaceState) {
      var url = window.location.protocol + "//" + window.location.host + window.location.pathname;
      window.history.replaceState({path: url}, '', url);
    }
  </script>
</c:if>

<script>
    (function() {
        window.history.pushState(null, "", window.location.href);
        window.onpopstate = function() {
            window.history.pushState(null, "", window.location.href);
        };
    })();
</script>

</body>
</html>