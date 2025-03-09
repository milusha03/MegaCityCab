package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.megacitycab.utils.DBConnection;

public class BookRideServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");

        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve booking details
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String vehicleId = request.getParameter("vehicleId");  
        String vehicleType = request.getParameter("vehicleType"); // Get selected vehicle type
        String paymentMethod = request.getParameter("paymentMethod");
        String distanceStr = request.getParameter("distance");
        String fareStr = request.getParameter("fare");

        double distance = 0;
        double fare = 0;
        try {
            distance = Double.parseDouble(distanceStr);
            fare = Double.parseDouble(fareStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid distance or fare format.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Current Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = sdf.format(new Date());

        // Debugging: Print values to check if they are received correctly
        System.out.println("Received parameters:");
        System.out.println("pickup: " + pickup);
        System.out.println("drop: " + drop);
        System.out.println("vehicleId: " + vehicleId);
        System.out.println("vehicleType: " + vehicleType);  // Print vehicle type to verify
        System.out.println("paymentMethod: " + paymentMethod);
        System.out.println("distance: " + distance);
        System.out.println("fare: " + fare);
        System.out.println("currentDate: " + currentDate);

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Database connection is null.");
            }

            // Insert booking details into database
            String sql = "INSERT INTO bookings (customer_id, driver_id, vehicle_id, vehicle_type, pickup_location, drop_location, distance,  booking_date, fare, payment, status) " +
                         "VALUES (?, NULL, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            stmt.setString(2, vehicleId);
            stmt.setString(3, vehicleType);  // Insert vehicle type
            stmt.setString(4, pickup);
            stmt.setString(5, drop);
            stmt.setDouble(6, distance);
            stmt.setString(7, currentDate);
            stmt.setDouble(8, fare);
            stmt.setString(9, paymentMethod); 
            

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("viewBookings.jsp");
            } else {
                request.setAttribute("errorMessage", "Booking could not be completed. Please try again.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
