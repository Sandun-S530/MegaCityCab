package com.megacitycab.model;

public class BookingSummary {
    private int totalBookings;
    private int pendingBookings;
    private int completedBookings;
    private int cancelledBookings;


    public int getTotalBookings() {
        return totalBookings;
    }
    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }
    public int getPendingBookings() {
        return pendingBookings;
    }
    public void setPendingBookings(int pendingBookings) {
        this.pendingBookings = pendingBookings;
    }
    public int getCompletedBookings() {
        return completedBookings;
    }
    public void setCompletedBookings(int completedBookings) {
        this.completedBookings = completedBookings;
    }
    public int getCancelledBookings() {
        return cancelledBookings;
    }
    public void setCancelledBookings(int cancelledBookings) {
        this.cancelledBookings = cancelledBookings;
    }
}
