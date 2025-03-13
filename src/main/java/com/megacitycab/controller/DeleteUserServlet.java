package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        HttpSession session = request.getSession();

        boolean hasBookings = UserDAO.hasAssignedBookings(userId);
        if (hasBookings) {
            session.setAttribute("message", "Cannot delete user: They have assigned bookings.");
            response.sendRedirect("AdminDashboardServlet");
            return;
        }

        boolean deleted = UserDAO.deleteUser(userId);
        if (deleted) {
            session.setAttribute("message", "User deleted successfully.");
        } else {
            session.setAttribute("message", "Failed to delete user.");
        }

        response.sendRedirect("AdminDashboardServlet");
    }
}
