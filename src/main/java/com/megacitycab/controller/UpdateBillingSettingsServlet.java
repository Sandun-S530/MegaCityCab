package com.megacitycab.controller;

import com.megacitycab.dao.BillingDAO;
import com.megacitycab.model.BillingSettings;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateBillingSettingsServlet")
public class UpdateBillingSettingsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            double baseRate = Double.parseDouble(request.getParameter("baseRate"));
            double taxRate = Double.parseDouble(request.getParameter("taxRate"));
            double discountThreshold = Double.parseDouble(request.getParameter("discountThreshold"));
            double discountRate = Double.parseDouble(request.getParameter("discountRate"));

            BillingSettings settings = new BillingSettings();
            settings.setBaseRate(baseRate);
            settings.setTaxRate(taxRate);
            settings.setDiscountThreshold(discountThreshold);
            settings.setDiscountRate(discountRate);

            boolean updated = BillingDAO.updateBillingSettings(settings);
            if (updated) {
                response.sendRedirect("AdminDashboardServlet?success=billingSettings");
            } else {
                response.sendRedirect("AdminDashboardServlet?error=billingSettings");
            }
        } catch(NumberFormatException ex) {
            ex.printStackTrace();
            response.sendRedirect("AdminDashboardServlet?error=billingSettings");
        }
    }
}
