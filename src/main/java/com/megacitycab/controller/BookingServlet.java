package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.Booking;
import com.megacitycab.model.User;
import com.megacitycab.util.BillingCalculator;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"customer".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String pickup = request.getParameter("pickup");
        String destination = request.getParameter("destination");
        String bookingDate = request.getParameter("bookingDate");  
        String bookingTime = request.getParameter("bookingTime");  
        String vehicleType = request.getParameter("vehicleType");
        String tripKmStr = request.getParameter("tripKm");
        double tripKm = 0;
        try {
            tripKm = Double.parseDouble(tripKmStr);
        } catch (NumberFormatException e) {
           
            tripKm = 0;
        }
        
        
        String bookingNumber = "BKG" + System.currentTimeMillis();
              
        double estimatedBill = BillingCalculator.calculateEstimatedBill(tripKm);
        
        Booking booking = new Booking();                     
        booking.setBookingNumber(bookingNumber);
        booking.setCustomerId(user.getUserId());
        booking.setPickupLocation(pickup);
        booking.setDestination(destination);
        booking.setBookingDate(bookingDate);
        booking.setBookingTime(bookingTime);
        booking.setRequiredVehicleType(vehicleType);
        booking.setTripKm(tripKm);
        booking.setEstimatedBill(estimatedBill);
        booking.setStatus("pending");
        

        boolean result = BookingDAO.addBooking(booking);
        if (result) {
        	response.sendRedirect("CustomerDashboardServlet?success=bookingCreated");
        } else {
            response.sendRedirect("CustomerDashboardServlet?error=1");
        }
    }
}
