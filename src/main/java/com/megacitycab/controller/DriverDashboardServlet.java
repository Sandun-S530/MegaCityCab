package com.megacitycab.controller;

import com.megacitycab.dao.BillingDAO;
import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.BillingSettings;
import com.megacitycab.model.Booking;
import com.megacitycab.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DriverDashboardServlet")
public class DriverDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"driver".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        

        List<Booking> assignedBookings = BookingDAO.getBookingsByDriver(user.getUserId());
        List<Booking> completedBookings = BookingDAO.getCompletedBookingsByDriver(user.getUserId()); 
        request.setAttribute("assignedBookings", assignedBookings);
        request.setAttribute("completedBookings", completedBookings);
        
        BillingSettings billingSettings = BillingDAO.getBillingSettings();
        request.setAttribute("billingSettings", billingSettings);

        
        request.getRequestDispatcher("DriverDashboard.jsp").forward(request, response);
    }
}
