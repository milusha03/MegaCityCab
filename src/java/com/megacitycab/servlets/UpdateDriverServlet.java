package com.megacitycab.servlets;  // Change this to match your package

import com.megacitycab.dao.DriverDAO;
import com.megacitycab.model.Driver;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class UpdateDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int driverId = Integer.parseInt(request.getParameter("driver_id"));
    String fullName = request.getParameter("full_name");
    String licenseNumber = request.getParameter("license_number");
    String phoneNumber = request.getParameter("phone_number");
    String address = request.getParameter("address");

    System.out.println("Updating driver ID: " + driverId); // Debugging

    Driver driver = new Driver(driverId, fullName, licenseNumber, phoneNumber, address);
    DriverDAO driverDAO = new DriverDAO();
    boolean updateSuccess = driverDAO.updateDriver(driver);

    if (updateSuccess) {
        response.sendRedirect("driverList.jsp?message=Driver updated successfully");
    } else {
        System.out.println("Driver update failed"); // Debugging
        response.sendRedirect("editDriver.jsp?error=Failed to update driver.");
    }

    }
}
