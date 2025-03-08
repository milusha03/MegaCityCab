package com.megacitycab.servlets;

import com.megacitycab.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String licenseNumber = request.getParameter("license_number");
        String phoneNumber = request.getParameter("phone_number");
        String vehicleNumber = request.getParameter("vehicle_number");
        String vehicleType = request.getParameter("vehicle_type");
        int capacity = Integer.parseInt(request.getParameter("capacity"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO drivers (full_name, license_number, phone_number, vehicle_number, vehicle_type, capacity) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, licenseNumber);
            stmt.setString(3, phoneNumber);
            stmt.setString(4, vehicleNumber);
            stmt.setString(5, vehicleType);
            stmt.setInt(6, capacity);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("addDrivers.jsp?message=Driver added successfully.");
            } else {
                response.sendRedirect("addDrivers.jsp?error=Failed to add driver.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addDrivers.jsp?error=Database error.");
        }
    }
}
