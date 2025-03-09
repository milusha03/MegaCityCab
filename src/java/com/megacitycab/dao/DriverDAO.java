package com.megacitycab.dao;

import com.megacitycab.model.Driver;
import com.megacitycab.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DriverDAO {
    public boolean updateDriver(Driver driver) {
        boolean rowUpdated = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE drivers SET full_name=?, license_number=?, phone_number=?, address=? WHERE driver_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, driver.getFullName());
            stmt.setString(2, driver.getLicenseNumber());
            stmt.setString(3, driver.getPhoneNumber());
            stmt.setString(4, driver.getAddress());
            stmt.setInt(5, driver.getDriverId());

            rowUpdated = stmt.executeUpdate() > 0;
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
    
public Driver getDriverById(int driverId) {
    Driver driver = null;
    String query = "SELECT * FROM drivers WHERE driver_id = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, driverId);
        System.out.println("Executing Query: " + ps.toString());  // Debugging

        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            driver = new Driver();
            driver.setDriverId(rs.getInt("driver_id"));
            driver.setFullName(rs.getString("full_name"));
            driver.setLicenseNumber(rs.getString("license_number"));
            driver.setPhoneNumber(rs.getString("phone_number"));
            driver.setAddress(rs.getString("address"));

            System.out.println("Driver Found: " + driver.getFullName()); // Debugging
        } else {
            System.out.println("Driver not found in database!"); // Debugging
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return driver;
}

}
