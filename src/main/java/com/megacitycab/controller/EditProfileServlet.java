package com.megacitycab.controller;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = UserDAO.getUserById(sessionUser.getUserId());
        if (user != null) {
            session.setAttribute("user", user);
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
    }
}
