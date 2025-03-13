package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CompleteBookingServlet")
public class CompleteBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        boolean updated = BookingDAO.completeBooking(bookingId);
        if(updated) {

            response.sendRedirect("DriverDashboardServlet");
        } else {
            response.sendRedirect("DriverDashboardServlet?error=complete");
        }
    }
}
