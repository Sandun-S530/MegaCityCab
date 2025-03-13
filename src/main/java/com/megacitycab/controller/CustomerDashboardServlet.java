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

@WebServlet("/CustomerDashboardServlet")
public class CustomerDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"customer".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        

        int page = 1;
        int pageSize = 10; 
        String pageParam = request.getParameter("page");
        if(pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch(NumberFormatException e) {
                page = 1;
            }
        }
        
        List<Booking> bookings = BookingDAO.getBookingsByCustomerPaginated(user.getUserId(), page, pageSize);
        int totalCount = BookingDAO.getBookingsCountByCustomer(user.getUserId());
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        
        request.setAttribute("bookings", bookings);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        
        BillingSettings billingSettings = BillingDAO.getBillingSettings();
        request.setAttribute("billingSettings", billingSettings);
        
        request.getRequestDispatcher("CustomerDashboard.jsp").forward(request, response);
    }
}
