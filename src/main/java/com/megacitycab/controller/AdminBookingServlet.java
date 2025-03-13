package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.Booking;
import com.megacitycab.model.User;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminBookingServlet")
public class AdminBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Booking> pendingBookings = BookingDAO.getPendingBookings();
        Map<Integer, List<User>> bookingDriversMap = new HashMap<>();
        
        for (Booking booking : pendingBookings) {
            List<User> availableDrivers = UserDAO.getDriversByVehicleType(booking.getRequiredVehicleType());
            bookingDriversMap.put(booking.getBookingId(), availableDrivers);
        }
        
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("bookingDriversMap", bookingDriversMap);
        request.getRequestDispatcher("AdminDashboardServlet").forward(request, response);
    }
}
