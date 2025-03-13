package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = UserDAO.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("editUser.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String telephone = request.getParameter("telephone");

        User user = UserDAO.getUserById(userId);
        user.setFullName(fullName);
        user.setAddress(address);
        user.setNic(nic);
        user.setTelephone(telephone);

        boolean updated = UserDAO.updateUser(user);

        if (updated) {
            response.sendRedirect("AdminDashboardServlet?message=User details updated successfully.");
        } else {
            response.sendRedirect("AdminDashboardServlet?message=Failed to update user details.");
        }
    }
}
