package com.megacitycab.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.megacitycab.model.Booking;
import com.megacitycab.model.BookingSummary;
import com.megacitycab.model.RevenueReport;
import com.megacitycab.util.BillingCalculator;
import com.megacitycab.util.DBConnection;

public class BookingDAO {

    public static boolean addBooking(Booking booking) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "INSERT INTO bookings (booking_number, customer_id, pickup_location, destination, booking_date, booking_time, required_vehicle_type, trip_km, estimated_bill, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, booking.getBookingNumber());
            ps.setInt(2, booking.getCustomerId());
            ps.setString(3, booking.getPickupLocation());
            ps.setString(4, booking.getDestination());
            ps.setString(5, booking.getBookingDate());
            ps.setString(6, booking.getBookingTime());
            ps.setString(7, booking.getRequiredVehicleType());
            ps.setDouble(8, booking.getTripKm());
            ps.setDouble(9, booking.getEstimatedBill());
            ps.setString(10, booking.getStatus());
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return status;
    }
    
    
    // For Admin: Get pending bookings
    public static List<Booking> getPendingBookings() {
        List<Booking> pendingBookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bookings WHERE status = 'pending'";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingNumber(rs.getString("booking_number"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setRequiredVehicleType(rs.getString("required_vehicle_type"));
                booking.setTripKm(rs.getDouble("trip_km"));
                booking.setEstimatedBill(rs.getDouble("estimated_bill"));
                booking.setStatus(rs.getString("status"));
                pendingBookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return pendingBookings;
    }
    
    // For Admin: Assign driver to booking
    public static boolean assignDriverToBooking(int bookingId, int driverId) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE bookings SET driver_id = ?, status = 'assigned' WHERE booking_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, driverId);
            ps.setInt(2, bookingId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return status;
    }
    
    // For Driver: Get bookings assigned to a driver
    public static List<Booking> getBookingsByDriver(int driverId) {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bookings WHERE driver_id = ? AND status IN ('assigned','ongoing')";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, driverId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingNumber(rs.getString("booking_number"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setEstimatedBill(rs.getDouble("estimated_Bill"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return bookings;
    }
    
    public static boolean completeBooking(int bookingId) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;

        double estimatedBill = 0;
        String selectSql = "SELECT estimated_bill FROM bookings WHERE booking_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(selectSql);
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                estimatedBill = rs.getDouble("estimated_bill");
            }
            rs.close();
            ps.close();
            

            double finalBill = BillingCalculator.calculateFinalBill(estimatedBill);
            
            String sql = "UPDATE bookings SET status = 'completed', final_bill = ? WHERE booking_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, finalBill);
            ps.setInt(2, bookingId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return status;
    }

    
    public static List<Booking> getBookingHistory() {
        List<Booking> historyBookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM bookings WHERE status IN ('completed', 'cancelled')";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingNumber(rs.getString("booking_number"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setRequiredVehicleType(rs.getString("required_vehicle_type"));
                booking.setTripKm(rs.getDouble("trip_km"));
                booking.setEstimatedBill(rs.getDouble("estimated_bill"));
                booking.setFinalBill(rs.getDouble("final_bill"));
                booking.setStatus(rs.getString("status"));
                historyBookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return historyBookings;
    }
    
    public static List<Booking> getBookingsByCustomerPaginated(int customerId, int page, int pageSize) {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        // offset
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM bookings WHERE customer_id = ? ORDER BY booking_date DESC LIMIT ? OFFSET ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setInt(2, pageSize);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            while(rs.next()){
            	Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingNumber(rs.getString("booking_number"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setRequiredVehicleType(rs.getString("required_vehicle_type"));
                booking.setTripKm(rs.getDouble("trip_km"));
                booking.setEstimatedBill(rs.getDouble("estimated_bill"));
                booking.setFinalBill(rs.getDouble("final_bill")); 
                booking.setStatus(rs.getString("status"));

                bookings.add(booking);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try{
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(SQLException ex) {
                ex.printStackTrace();
            }
        }
        return bookings;
    }

   
    public static int getBookingsCountByCustomer(int customerId) {
        int count = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM bookings WHERE customer_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try{
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(SQLException ex) {
                ex.printStackTrace();
            }
        }
        return count;
    }

    public static List<Booking> getCompletedBookingsByDriver(int driverId) {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bookings WHERE driver_id = ? AND status = 'completed'";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, driverId);
            rs = ps.executeQuery();
            while(rs.next()){
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingNumber(rs.getString("booking_number"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setRequiredVehicleType(rs.getString("required_vehicle_type"));
                booking.setTripKm(rs.getDouble("trip_km"));
                booking.setEstimatedBill(rs.getDouble("estimated_bill"));
                booking.setFinalBill(rs.getDouble("final_bill"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try{
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(SQLException ex) {
                ex.printStackTrace();
            }
        }
        return bookings;
    }
    
    
 // Get booking summary-for a given date range
    public static BookingSummary getBookingSummary(String startDate, String endDate) {
        BookingSummary summary = new BookingSummary();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT " +
                     "COUNT(*) as total, " +
                     "SUM(CASE WHEN status IN ('pending','assigned','ongoing') THEN 1 ELSE 0 END) as pending, " +
                     "SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed, " +
                     "SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) as cancelled " +
                     "FROM bookings " +
                     "WHERE booking_date BETWEEN ? AND ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            rs = ps.executeQuery();
            if(rs.next()){
                summary.setTotalBookings(rs.getInt("total"));
                summary.setPendingBookings(rs.getInt("pending"));
                summary.setCompletedBookings(rs.getInt("completed"));
                summary.setCancelledBookings(rs.getInt("cancelled"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try{
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
        }
        return summary;
    }

    // Get revenue report-for completed bookings
    public static RevenueReport getRevenueReport(String startDate, String endDate) {
        RevenueReport report = new RevenueReport();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(final_bill) as totalRevenue, AVG(final_bill) as averageRevenue " +
                     "FROM bookings " +
                     "WHERE status = 'completed' AND booking_date BETWEEN ? AND ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            rs = ps.executeQuery();
            if(rs.next()){
                report.setTotalRevenue(rs.getDouble("totalRevenue"));
                report.setAverageRevenue(rs.getDouble("averageRevenue"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try{
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
        }
        return report;
    }



}
