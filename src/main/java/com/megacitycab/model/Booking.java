package com.megacitycab.model;

import java.util.Date;

public class Booking {
    private int bookingId;
    private String bookingNumber;
    private int customerId;
    private String pickupLocation;
    private String destination;
    private String bookingDate;           
    private String bookingTime;           
    private String requiredVehicleType;
    private double tripKm;
    private double estimatedBill;
    private Double finalBill;             
    private String status;                
    private Integer driverId;            
    private Date createdAt;
    private Date updatedAt;
    
    public Booking() {
    }
    
    public Booking(int bookingId, String bookingNumber, int customerId, String pickupLocation, 
                   String destination, String bookingDate, String bookingTime, String requiredVehicleType, 
                   double tripKm, double estimatedBill, Double finalBill, String status, Integer driverId, 
                   Date createdAt, Date updatedAt) {
        this.bookingId = bookingId;
        this.bookingNumber = bookingNumber;
        this.customerId = customerId;
        this.pickupLocation = pickupLocation;
        this.destination = destination;
        this.bookingDate = bookingDate;
        this.bookingTime = bookingTime;
        this.requiredVehicleType = requiredVehicleType;
        this.tripKm = tripKm;
        this.estimatedBill = estimatedBill;
        this.finalBill = finalBill;
        this.status = status;
        this.driverId = driverId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    public int getBookingId() {
        return bookingId;
    }
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    public String getBookingNumber() {
        return bookingNumber;
    }
    public void setBookingNumber(String bookingNumber) {
        this.bookingNumber = bookingNumber;
    }
    public int getCustomerId() {
        return customerId;
    }
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    public String getPickupLocation() {
        return pickupLocation;
    }
    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }
    public String getDestination() {
        return destination;
    }
    public void setDestination(String destination) {
        this.destination = destination;
    }
    public String getBookingDate() {
        return bookingDate;
    }
    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }
    public String getBookingTime() {
        return bookingTime;
    }
    public void setBookingTime(String bookingTime) {
        this.bookingTime = bookingTime;
    }
    public String getRequiredVehicleType() {
        return requiredVehicleType;
    }
    public void setRequiredVehicleType(String requiredVehicleType) {
        this.requiredVehicleType = requiredVehicleType;
    }
    public double getTripKm() {
        return tripKm;
    }
    public void setTripKm(double tripKm) {
        this.tripKm = tripKm;
    }
    public double getEstimatedBill() {
        return estimatedBill;
    }
    public void setEstimatedBill(double estimatedBill) {
        this.estimatedBill = estimatedBill;
    }
    public Double getFinalBill() {
        return finalBill;
    }
    public void setFinalBill(Double finalBill) {
        this.finalBill = finalBill;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Integer getDriverId() {
        return driverId;
    }
    public void setDriverId(Integer driverId) {
        this.driverId = driverId;
    }
    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    public Date getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "Booking [bookingId=" + bookingId + ", bookingNumber=" + bookingNumber + 
               ", customerId=" + customerId + ", pickupLocation=" + pickupLocation + 
               ", destination=" + destination + ", status=" + status + "]";
    }
}
