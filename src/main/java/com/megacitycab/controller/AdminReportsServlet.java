package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.BookingSummary;
import com.megacitycab.model.RevenueReport;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminReportsServlet")
public class AdminReportsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");
        
        LocalDate endDate;
        LocalDate startDate;
        if(endDateParam != null && startDateParam != null) {
            endDate = LocalDate.parse(endDateParam);
            startDate = LocalDate.parse(startDateParam);
        } else {
            endDate = LocalDate.now();
            startDate = endDate.minusDays(30);
        }
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startDateStr = startDate.format(formatter);
        String endDateStr = endDate.format(formatter);
        
        BookingSummary summary = BookingDAO.getBookingSummary(startDateStr, endDateStr);
        RevenueReport revenue = BookingDAO.getRevenueReport(startDateStr, endDateStr);
        
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);
        request.setAttribute("bookingSummary", summary);
        request.setAttribute("revenueReport", revenue);
        
        request.getRequestDispatcher("adminReports.jsp").forward(request, response);
    }
}
