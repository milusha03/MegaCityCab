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
        int capacity = Integer.parseInt(request.getParameter("capacity"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int driverId = -1;

        try {
            conn = DBConnection.getConnection();
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

            // Insert into vehicles table
            if (driverId != -1) {
                String insertVehicleSQL = "INSERT INTO vehicles (vehicle_number, vehicle_type, capacity) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertVehicleSQL);
                pstmt.setString(1, vehicleNumber);
                pstmt.setString(2, vehicleType);
                pstmt.setInt(3, capacity);
                pstmt.executeUpdate();
            }

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
            response.sendRedirect("addDrivers.jsp?error=1");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
