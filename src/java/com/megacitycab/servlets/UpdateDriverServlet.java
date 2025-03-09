package com.megacitycab.servlets;

import com.megacitycab.dao.DriverDAO;
import com.megacitycab.model.Driver;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class UpdateDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        String driverIdStr = request.getParameter("driver_id");
        System.out.println("Received driver_id: " + driverIdStr); // Debugging

        if (driverIdStr == null || driverIdStr.isEmpty()) {
            response.sendRedirect("editDriver.jsp?error=Invalid Driver ID");
            return;
        }

        int driverId = Integer.parseInt(driverIdStr);
        DriverDAO driverDAO = new DriverDAO();
        Driver driver = driverDAO.getDriverById(driverId);

        if (driver == null) {
            response.sendRedirect("editDriver.jsp?error=Driver not found!");
            return;
        }

        // Get updated data
        String fullName = request.getParameter("full_name");
        String licenseNumber = request.getParameter("license_number");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");

        // Update driver details
        driver.setFullName(fullName);
        driver.setLicenseNumber(licenseNumber);
        driver.setPhoneNumber(phoneNumber);
        driver.setAddress(address);

        // Save update
        boolean updated = driverDAO.updateDriver(driver);
        if (updated) {
            response.sendRedirect("editDriver.jsp?message=Driver updated successfully.");
        } else {
            response.sendRedirect("editDriver.jsp?error=Failed to update driver.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("editDriver.jsp?error=Server error.");
    }
}
}

