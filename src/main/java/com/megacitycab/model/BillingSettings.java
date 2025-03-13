package com.megacitycab.model;

public class BillingSettings {
    private double baseRate;
    private double taxRate;
    private double discountThreshold;
    private double discountRate;

    public double getBaseRate() {
        return baseRate;
    }
    public void setBaseRate(double baseRate) {
        this.baseRate = baseRate;
    }
    public double getTaxRate() {
        return taxRate;
    }
    public void setTaxRate(double taxRate) {
        this.taxRate = taxRate;
    }
    public double getDiscountThreshold() {
        return discountThreshold;
    }
    public void setDiscountThreshold(double discountThreshold) {
        this.discountThreshold = discountThreshold;
    }
    public double getDiscountRate() {
        return discountRate;
    }
    public void setDiscountRate(double discountRate) {
        this.discountRate = discountRate;
    }
}
