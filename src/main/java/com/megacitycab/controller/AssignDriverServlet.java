package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AssignDriverServlet")
public class AssignDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        
        boolean updated = BookingDAO.assignDriverToBooking(bookingId, driverId);
        if (updated) {
            response.sendRedirect("AdminBookingServlet");
        } else {
            response.sendRedirect("AdminDashboardServlet?error=assign");
        }
    }
}
