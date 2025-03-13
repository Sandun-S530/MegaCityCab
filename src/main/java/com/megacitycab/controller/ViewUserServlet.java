package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewUserServlet")
public class ViewUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        int userId = 0;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch(NumberFormatException e) {
            response.sendRedirect("ManageUsersServlet?error=invalidUserId");
            return;
        }
        User user = UserDAO.getUserById(userId);
        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("viewUser.jsp").forward(request, response);
        } else {
            response.sendRedirect("ManageUsersServlet?error=userNotFound");
        }
    }
}
