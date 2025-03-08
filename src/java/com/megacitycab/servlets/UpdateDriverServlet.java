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
import com.megacitycab.dao.DriverDAO;



public class UpdateDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String driverIdStr = request.getParameter("driver_id");  // Fetch driver_id

    if (driverIdStr == null || driverIdStr.trim().isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Driver ID is missing or invalid.");
        return;
    }

    int driverId;
    try {
        driverId = Integer.parseInt(driverIdStr);
    } catch (NumberFormatException e) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Driver ID format.");
        return;
    }

    String fullName = request.getParameter("full_name");
    String licenseNumber = request.getParameter("license_number");
    String phoneNumber = request.getParameter("phone_number");
    String vehicleNumber = request.getParameter("vehicle_number");
    String vehicleType = request.getParameter("vehicle_type");
    String capacity = request.getParameter("capacity");

    if (fullName == null || licenseNumber == null || phoneNumber == null || 
        vehicleNumber == null || vehicleType == null || capacity == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields.");
        return;
    }

    // Update database logic
    DriverDAO driverDAO = new DriverDAO();
    boolean updateSuccess = driverDAO.updateDriver(driverId, fullName, licenseNumber, phoneNumber, vehicleNumber, vehicleType, capacity);

    if (updateSuccess) {
        response.sendRedirect("viewDrivers.jsp?success=Driver updated successfully");
    } else {
        response.sendRedirect("viewDrivers.jsp?error=Failed to update driver");
    }
    }}
