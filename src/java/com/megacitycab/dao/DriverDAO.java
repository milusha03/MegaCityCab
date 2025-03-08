package com.megacitycab.dao;

import com.megacitycab.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class DriverDAO {
    public boolean updateDriver(int driverId, String fullName, String licenseNumber, 
                                String phoneNumber, String vehicleNumber, 
                                String vehicleType, String capacity) {
        boolean success = false;
        String sql = "UPDATE drivers SET full_name=?, license_number=?, phone_number=?, vehicle_number=?, vehicle_type=?, capacity=? WHERE driver_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, fullName);
            stmt.setString(2, licenseNumber);
            stmt.setString(3, phoneNumber);
            stmt.setString(4, vehicleNumber);
            stmt.setString(5, vehicleType);
            stmt.setString(6, capacity);
            stmt.setInt(7, driverId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}
