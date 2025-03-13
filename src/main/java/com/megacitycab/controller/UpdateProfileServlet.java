package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String telephone = request.getParameter("telephone");
        
        user.setFullName(fullName);
        user.setAddress(address);
        user.setNic(nic);
        user.setTelephone(telephone);
        
        if ("driver".equals(user.getRole())) {
            String licenseNumber = request.getParameter("licenseNumber");
            String vehicleNumber = request.getParameter("vehicleNumber");
            String vehicleType = request.getParameter("vehicleType");
            
            user.setLicenseNumber(licenseNumber);
            user.setVehicleNumber(vehicleNumber);
            user.setVehicleType(vehicleType);
        }
        
        boolean updated = UserDAO.updateUser(user);
        if (updated) {
            session.setAttribute("user", user);
            response.sendRedirect("CustomerDashboardServlet?success=profile");
        } else {
            response.sendRedirect("updateProfile.jsp?error=1");
        }
    }
}
