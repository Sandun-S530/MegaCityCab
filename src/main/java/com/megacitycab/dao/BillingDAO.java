package com.megacitycab.dao;

import java.sql.*;
import com.megacitycab.model.BillingSettings;
import com.megacitycab.util.DBConnection;

public class BillingDAO {

    public static BillingSettings getBillingSettings() {
        BillingSettings settings = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM billing_settings LIMIT 1";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if(rs.next()){
                settings = new BillingSettings();
                settings.setBaseRate(rs.getDouble("base_rate"));
                settings.setTaxRate(rs.getDouble("tax_rate"));
                settings.setDiscountThreshold(rs.getDouble("discount_threshold"));
                settings.setDiscountRate(rs.getDouble("discount_rate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return settings;
    }
    
    public static boolean updateBillingSettings(BillingSettings settings) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE billing_settings SET base_rate = ?, tax_rate = ?, discount_threshold = ?, discount_rate = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, settings.getBaseRate());
            ps.setDouble(2, settings.getTaxRate());
            ps.setDouble(3, settings.getDiscountThreshold());
            ps.setDouble(4, settings.getDiscountRate());
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
}
