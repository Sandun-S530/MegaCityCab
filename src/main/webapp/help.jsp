<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help & Support</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 30px;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        .card {
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1, h2 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1 class="text-primary">Help & Support</h1>
        <c:choose>
        
		    <c:when test="${sessionScope.user.role eq 'customer'}">
				<h2>Customer Help</h2>
				<p>Welcome to the Mega City Cab system! As a customer, you have a range of features available to you. Follow these detailed guidelines to make the most of the system:</p>
				
				<h3>Create a Booking</h3>
				<ul>
				    <li><strong>Step 1: Log In</strong>
				        <ul>
				            <li>Use your registered username and password on the login page.</li>
				        </ul>
				    </li>
				    <li><strong>Step 2: Navigate to the Booking Section</strong>
				        <ul>
				            <li>After logging in, your dashboard will display a "Create a New Booking" form.</li>
				        </ul>
				    </li>
				    <li><strong>Step 3: Fill in the Booking Form</strong>
				        <ul>
				            <li><em>Pickup Location:</em> Enter your starting address or location accurately.</li>
				            <li><em>Destination:</em> Enter your desired destination.</li>
				            <li><em>Booking Date:</em> Select a date from the date picker. Only dates from today onward are available.</li>
				            <li><em>Booking Time:</em> Choose a time using the time picker. If you select today’s date, only future times will be allowed.</li>
				            <li><em>Required Vehicle Type:</em> Choose the type of vehicle you prefer (Car, Van, SUV, or Motorbike) from the drop-down list.</li>
				            <li><em>Trip Distance:</em> Enter the estimated trip distance in kilometers. The system will use this value to calculate your estimated bill.</li>
				        </ul>
				    </li>
				    <li><strong>Step 4: Submit Your Booking</strong>
				        <ul>
				            <li>Click the "Submit Booking" button. Your estimated bill will be calculated automatically and your booking will be added to your list.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>View Bookings</h3>
				<ul>
				    <li><strong>Step 1: Access Your Bookings</strong>
				        <ul>
				            <li>Your dashboard displays a table of your current and past bookings.</li>
				        </ul>
				    </li>
				    <li><strong>Step 2: Review Booking Details</strong>
				        <ul>
				            <li>The table includes the booking number, pickup location, destination, date, and the status.</li>
				        </ul>
				    </li>
				    <li><strong>Step 3: Navigate Through Your Bookings</strong>
				        <ul>
				            <li>If you have many bookings, use the pagination controls at the bottom of the table to view older or more recent bookings.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>Update Profile</h3>
				<ul>
				    <li><strong>Step 1: Access the Update Profile Page</strong>
				        <ul>
				            <li>Click the "Update Profile" button on your dashboard.</li>
				        </ul>
				    </li>
				    <li><strong>Step 2: Review Your Information</strong>
				        <ul>
				            <li>Your current profile details will be pre-filled in the form.</li>
				        </ul>
				    </li>
				    <li><strong>Step 3: Edit Your Information</strong>
				        <ul>
				            <li>Update any details that need to be changed (e.g., full name, address, NIC, telephone).</li>
				        </ul>
				    </li>				    
				    <li><strong>Step 4: Save Changes</strong>
				        <ul>
				            <li>Click the "Update Profile" button to save your changes. You will receive confirmation if the update is successful.</li>
				        </ul>
				    </li>
				</ul>
				
				<p>If you have further questions or need assistance, please contact our support team at <a href="mailto:megacitycab@gmail.com">megacitycab@gmail.com</a>.</p>
		    </c:when>
		    
		    <c:when test="${sessionScope.user.role eq 'driver'}">
				<h2>Driver Help</h2>
				<p>Welcome to the Mega City Cab system! As a driver, here is a detailed guide on how to use the system:</p>
				
				<h3>1. View Assigned Bookings</h3>
				<ul>
				    <li><strong>Step 1: Log In</strong>
				        <ul>
				            <li>Use your driver credentials on the login page.</li>
				        </ul>
				    </li>
				    <li><strong>Step 2: Access Your Dashboard</strong>
				        <ul>
				            <li>After logging in, your dashboard will display a list of bookings that have been assigned to you.</li>
				            <li>The list shows important details such as the booking number, pickup location, destination, date, and current status.</li>
				        </ul>
				    </li>
				    <li><strong>Step 3: Review Your Bookings</strong>
				        <ul>
				            <li>Scroll through the list to see all active bookings.</li>
				            
				        </ul>
				    </li>
				</ul>
				
				<h3>2. Complete a Booking</h3>
				<ul>
				    <li><strong>Step 1: Identify the Booking</strong>
				        <ul>
				            <li>Locate the booking you have completed from the active bookings list on your dashboard.</li>
				        </ul>
				    </li>
				    <li><strong>Step 2: Mark as Completed</strong>
				        <ul>
				            <li>Click the <em>"Mark as Completed"</em> button next to the corresponding booking.</li>
				        </ul>
				    </li>
				    <li><strong>Step 3: Bill Calculation</strong>
				        <ul>
				            <li>Once you mark the booking as completed, the system will calculate the final bill using the current billing settings (including base rate, tax, and any applicable discounts).</li>
				            <li>The final bill will then be updated and can be viewed in your booking history.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>3. Update Profile</h3>
				<ul>
				    <li><strong>Step 1: Navigate to Profile Update</strong>
				        <ul>
				            <li>Click the <em>"Update Profile"</em> button on your dashboard.</li>
				        </ul>
				    </li>
				    <li><strong>Step 2: Review and Edit Details</strong>
				        <ul>
				            <li>Your current profile information will be pre-filled on the update page.</li>
				            <li>Make any necessary changes to your personal and vehicle details.</li>
				        </ul>
				    </li>
				    <li><strong>Step 3: Save Changes</strong>
				        <ul>
				            <li>Click the <em>"Update Profile"</em> button to save your changes.</li>
				            <li>You will receive a confirmation if your profile was successfully updated.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>4. Additional Assistance</h3>
				<ul>
				    <li>If you encounter any issues or have questions about using the system, please contact our support team at <a href="mailto:megacitycab@gmail.com">megacitycab@gmail.com</a>.</li>
				</ul>

		    </c:when>
		    
		    <c:when test="${sessionScope.user.role eq 'admin'}">
		        <h2>Admin Help</h2>
				<p>Welcome to the Mega City Cab system! As an admin, you have a variety of powerful tools to manage the system. Follow these detailed guidelines to use each feature effectively:</p>
				
				<h3>1. Manage Bookings</h3>
				<ul>
				    <li>
				        <strong>View Pending Bookings:</strong>
				        <ul>
				            <li>Log in with your admin credentials and navigate to the Admin Dashboard.</li>
				            <li>The "Pending Bookings" section displays all bookings that have not yet been assigned or are awaiting driver confirmation.</li>
				            <li>You can review details such as booking number, pickup location, destination, date, and the required vehicle type.</li>
				        </ul>
				    </li>
				    <li>
				        <strong>Assign Drivers:</strong>
				        <ul>
				            <li>For each pending booking, use the provided dropdown to select an available driver whose vehicle matches the required type.</li>
				            <li>Click the "Assign" button to assign the selected driver.</li>
				            <li>The booking status will update to "assigned," and the driver will be notified of the assignment.</li>
				        </ul>
				    </li>
				    <li>
				        <strong>Review Booking History:</strong>
				        <ul>
				            <li>The "Booking History" section displays all completed or cancelled bookings.</li>
				            <li>You can review details including booking number, pickup, destination, date, status, and bill amount.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>2. Manage Users</h3>
				<ul>
				    <li>
				        <strong>View Users:</strong>
				        <ul>
				            <li>The "Manage Users" section lists all customer, driver, and admin accounts with basic details (User ID, username, role, and full name).</li>
				        </ul>
				    </li>
				    <li>
				        <strong>Edit User Details:</strong>
				        <ul>
				            <li>Click the "Edit" button next to a user’s entry to update their profile information.</li>
				            <li>If the user is a driver, you will also be able to edit vehicle and license information.</li>
				        </ul>
				    </li>
				    <li>
				        <strong>Delete Users:</strong>
				        <ul>
				            <li>If a user account is no longer needed, click the "Delete" button.</li>
				            <li>You will be prompted to confirm the deletion. Note that this action is irreversible.</li>
				        </ul>
				    </li>
				    <li>
				        <strong>View Full Details:</strong>
				        <ul>
				            <li>Click the "View Details" button to see all information related to a user, including registration date and, if applicable, additional driver information.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>3. Billing Settings</h3>
				<ul>
				    <li>
				        <strong>View Current Settings:</strong>
				        <ul>
				            <li>The "Billing Settings" section displays the current billing parameters: base rate, tax rate, discount threshold, and discount rate.</li>
				        </ul>
				    </li>
				    <li>
				        <strong>Update Billing Parameters:</strong>
				        <ul>
				            <li>Change the <em>Base Rate</em> to set the price per kilometer.</li>
				            <li>Adjust the <em>Tax Rate</em> (for example, 0.08 for 8%) as needed.</li>
				            <li>Set the <em>Discount Threshold</em> (the minimum bill amount that qualifies for a discount).</li>
				            <li>Specify the <em>Discount Rate</em> (for example, 0.05 for 5%) for eligible bookings.</li>
				            <li>Click the "Update Billing Settings" button to save your changes. These settings affect how both estimated and final bills are calculated.</li>
				        </ul>
				    </li>
				</ul>
				
				<h3>4. Additional Assistance</h3>
				<ul>
				    <li>If you have any questions or encounter issues, please contact our support team <a href="mailto:megacitycab@gmail.com">megacitycab@gmail.com</a>.</li>
				</ul>
		    </c:when>
		    
		    <c:otherwise>
		        <p>Please log in to see help instructions.</p>
		    </c:otherwise>
		    
		</c:choose>

        <div class="text-center mt-4">
            <c:choose>
			    <c:when test="${sessionScope.user.role eq 'customer'}">
			        <a href="CustomerDashboardServlet" class="btn btn-primary">Return to Home</a>
			    </c:when>
			    <c:when test="${sessionScope.user.role eq 'driver'}">
			        <a href="DriverDashboardServlet" class="btn btn-primary">Return to Home</a>
			    </c:when>
			    <c:when test="${sessionScope.user.role eq 'admin'}">
			        <a href="AdminDashboardServlet" class="btn btn-primary">Return to Home</a>
			    </c:when>
			    <c:otherwise>
			        <p>Please log in to see help instructions.</p>
			    </c:otherwise>
			</c:choose>
        </div>
               
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
