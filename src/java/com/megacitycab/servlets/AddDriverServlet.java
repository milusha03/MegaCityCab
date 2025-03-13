package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.megacitycab.utils.DBConnection;

public class AddDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String licenseNumber = request.getParameter("license_number");
        String phoneNumber = request.getParameter("phone_number");
        String vehicleNumber = request.getParameter("vehicle_number");
        String vehicleType = request.getParameter("vehicle_type");
        String capacityStr = request.getParameter("capacity");

        // Validate inputs
        if (fullName == null || fullName.trim().isEmpty() ||
            licenseNumber == null || licenseNumber.trim().isEmpty() ||
            phoneNumber == null || phoneNumber.trim().isEmpty() ||
            vehicleNumber == null || vehicleNumber.trim().isEmpty() ||
            vehicleType == null || vehicleType.trim().isEmpty() ||
            capacityStr == null || capacityStr.trim().isEmpty()) {
            response.sendRedirect("addDrivers.jsp?error=All fields are required.");
            return;
        }

        int capacity;
        try {
            capacity = Integer.parseInt(capacityStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("addDrivers.jsp?error=Invalid capacity value.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int driverId = -1;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new Exception("Database connection failed!");
            }

            conn.setAutoCommit(false); // Start transaction

            // Insert into drivers table
            String insertDriverSQL = "INSERT INTO drivers (full_name, license_number, phone_number, vehicle_number, vehicle_type, capacity) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertDriverSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, fullName);
            pstmt.setString(2, licenseNumber);
            pstmt.setString(3, phoneNumber);
            pstmt.setString(4, vehicleNumber);
            pstmt.setString(5, vehicleType);
            pstmt.setInt(6, capacity);
            pstmt.executeUpdate();

            // Retrieve the generated driver_id
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                driverId = rs.getInt(1);
            }

            // Insert into vehicles table with driver_id
            String insertVehicleSQL = "INSERT INTO vehicles (vehicle_number, vehicle_type, capacity, driver_id) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertVehicleSQL);
            pstmt.setString(1, vehicleNumber);
            pstmt.setString(2, vehicleType);
            pstmt.setInt(3, capacity);
            pstmt.setInt(4, driverId); // Insert driver_id
            pstmt.executeUpdate();

            conn.commit(); // Commit transaction
            response.sendRedirect("addDrivers.jsp?success=1");

        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback in case of error
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.sendRedirect("addDrivers.jsp?error=" + e.getMessage().replace(" ", "%20")); // Show error details

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
