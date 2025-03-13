package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = UserDAO.authenticateUser(username, password);
        
        if(user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            Cookie loginCookie = new Cookie("loggedInUser", username);
            loginCookie.setMaxAge(60 * 60);
            response.addCookie(loginCookie);
            
            String role = user.getRole();
            if("customer".equals(role)) {
            	response.sendRedirect("CustomerDashboardServlet");
            } else if("driver".equals(role)) {
            	response.sendRedirect("DriverDashboardServlet");
            } else if("admin".equals(role)) {
                response.sendRedirect("AdminDashboardServlet");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
