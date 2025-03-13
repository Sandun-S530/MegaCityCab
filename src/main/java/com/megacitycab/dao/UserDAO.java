package com.megacitycab.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.megacitycab.model.User;
import com.megacitycab.util.DBConnection;

public class UserDAO {

    public static boolean registerUser(User user) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "INSERT INTO users (username, password, role, full_name, address, nic, telephone, license_number, vehicle_number, vehicle_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getNic());
            ps.setString(7, user.getTelephone());
            ps.setString(8, user.getLicenseNumber());
            ps.setString(9, user.getVehicleNumber());
            ps.setString(10, user.getVehicleType());
            
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
    
    public static User authenticateUser(String username, String password) {
        User user = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setFullName(rs.getString("full_name"));
                user.setAddress(rs.getString("address"));
                user.setNic(rs.getString("nic"));
                user.setTelephone(rs.getString("telephone"));
                user.setLicenseNumber(rs.getString("license_number"));
                user.setVehicleNumber(rs.getString("vehicle_number"));
                user.setVehicleType(rs.getString("vehicle_type"));
                user.setRegistrationDate(rs.getTimestamp("registration_date"));
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
        return user;
    }
    
    // Retrieve drivers by vehicle type- admin
    public static List<User> getDriversByVehicleType(String vehicleType) {
        List<User> drivers = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE role = 'driver' AND vehicle_type = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, vehicleType);
            rs = ps.executeQuery();
            while (rs.next()) {
                User driver = new User();
                driver.setUserId(rs.getInt("user_id"));
                driver.setUsername(rs.getString("username"));
                driver.setFullName(rs.getString("full_name"));
                driver.setVehicleType(rs.getString("vehicle_type"));
                drivers.add(driver);
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
        return drivers;
    }
    
    public static boolean updateUser(User user) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;
        String sql;
        
        
        if ("driver".equals(user.getRole())) {
            sql = "UPDATE users SET full_name=?, address=?, nic=?, telephone=?, license_number=?, vehicle_number=?, vehicle_type=? WHERE user_id=?";
        } else {
            sql = "UPDATE users SET full_name=?, address=?, nic=?, telephone=? WHERE user_id=?";
        }
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getAddress());
            ps.setString(3, user.getNic());
            ps.setString(4, user.getTelephone());
            
            if ("driver".equals(user.getRole())) {
                ps.setString(5, user.getLicenseNumber());
                ps.setString(6, user.getVehicleNumber());
                ps.setString(7, user.getVehicleType());
                ps.setInt(8, user.getUserId());
            } else {
                ps.setInt(5, user.getUserId());
            }
            
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

    
    public static User getUserById(int userId) {
        User user = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setFullName(rs.getString("full_name"));
                user.setAddress(rs.getString("address"));
                user.setNic(rs.getString("nic"));
                user.setTelephone(rs.getString("telephone"));
                user.setLicenseNumber(rs.getString("license_number"));
                user.setVehicleNumber(rs.getString("vehicle_number"));
                user.setVehicleType(rs.getString("vehicle_type"));
                user.setRegistrationDate(rs.getTimestamp("registration_date"));
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
        return user;
    }
    
    // Retrieve all users
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                user.setFullName(rs.getString("full_name"));
                user.setAddress(rs.getString("address"));
                user.setNic(rs.getString("nic"));
                user.setTelephone(rs.getString("telephone"));
                user.setLicenseNumber(rs.getString("license_number"));
                user.setVehicleNumber(rs.getString("vehicle_number"));
                user.setVehicleType(rs.getString("vehicle_type"));
                user.setRegistrationDate(rs.getTimestamp("registration_date"));
                users.add(user);
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
        return users;
    }
        
    // Delete user
    public static boolean deleteUser(int userId) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "DELETE FROM users WHERE user_id=?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            if(rows > 0){
                status = true;
            }
        } catch(SQLException e){
            e.printStackTrace();
        } finally {
            try{
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(SQLException ex){
                ex.printStackTrace();
            }
        }
        return status;
    }
    
    public static boolean hasAssignedBookings(int userId) {
        boolean hasBookings = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM bookings WHERE driver_id = ?";

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                hasBookings = true;
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
        return hasBookings;
    }



}
