package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String telephone = request.getParameter("telephone");
        String role = request.getParameter("role");
        String licenseNumber = request.getParameter("licenseNumber");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String vehicleType = request.getParameter("vehicleType");
        

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setFullName(fullName);
        newUser.setAddress(address);
        newUser.setNic(nic);
        newUser.setTelephone(telephone);
        newUser.setRole(role);
        
        if("driver".equals(role)) {
            newUser.setLicenseNumber(licenseNumber);
            newUser.setVehicleNumber(vehicleNumber);
            newUser.setVehicleType(vehicleType);
        }
        
        boolean registered = UserDAO.registerUser(newUser);
        
        if(registered) {
            Cookie regCookie = new Cookie("registeredUser", username);
            regCookie.setMaxAge(60 * 60);
            response.addCookie(regCookie);
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("registration.jsp?error=1");
        }
    }
}
