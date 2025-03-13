package com.megacitycab.controller;

import com.megacitycab.dao.BillingDAO;
import com.megacitycab.dao.BookingDAO;
import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.BillingSettings;
import com.megacitycab.model.Booking;
import com.megacitycab.model.User;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> pendingBookings = BookingDAO.getPendingBookings();
        
        List<Booking> bookingHistory = BookingDAO.getBookingHistory();
        
        List<User> users = UserDAO.getAllUsers();
        
        BillingSettings billSettings = BillingDAO.getBillingSettings();
        
        Map<Integer, List<User>> bookingDriversMap = new HashMap<>();
        for (Booking booking : pendingBookings) {
            List<User> drivers = UserDAO.getDriversByVehicleType(booking.getRequiredVehicleType());
            bookingDriversMap.put(booking.getBookingId(), drivers);
        }
        
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("bookingHistory", bookingHistory);
        request.setAttribute("users", users);
        request.setAttribute("billingSettings", billSettings);
        request.setAttribute("bookingDriversMap", bookingDriversMap);
        
        request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
    }
}