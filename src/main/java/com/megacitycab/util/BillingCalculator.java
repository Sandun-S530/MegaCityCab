package com.megacitycab.util;

import com.megacitycab.dao.BillingDAO;
import com.megacitycab.model.BillingSettings;

public class BillingCalculator {

    public static double calculateEstimatedBill(double tripKm) {
        BillingSettings settings = BillingDAO.getBillingSettings();
        if (settings == null) {
            settings = new BillingSettings();
            settings.setBaseRate(10.0);
            settings.setTaxRate(0.08);
            settings.setDiscountThreshold(100.0);
            settings.setDiscountRate(0.05);
        }
        return tripKm * settings.getBaseRate();
    }
    
    public static double calculateFinalBill(double estimatedBill) {
        BillingSettings settings = BillingDAO.getBillingSettings();
        if (settings == null) {
            settings = new BillingSettings();
            settings.setBaseRate(10.0);
            settings.setTaxRate(0.08);
            settings.setDiscountThreshold(100.0);
            settings.setDiscountRate(0.05);
        }
        double tax = estimatedBill * settings.getTaxRate();
        double discount = (estimatedBill > settings.getDiscountThreshold()) ? estimatedBill * settings.getDiscountRate() : 0;
        return estimatedBill + tax - discount;
    }
}
