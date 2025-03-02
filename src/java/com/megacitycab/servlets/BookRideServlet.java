package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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

        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String vehicleType = request.getParameter("vehicleType");
        String paymentMethod = request.getParameter("paymentMethod");
        double fare = Double.parseDouble(request.getParameter("fare"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();

            // Insert booking with status 'Pending'
            String sql = "INSERT INTO bookings (customer_id, pickup_location, drop_location, vehicle_id, fare, status, payment_method) " +
                         "VALUES (?, ?, ?, (SELECT vehicle_id FROM vehicles WHERE vehicle_type = ? LIMIT 1), ?, 'Pending', ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            stmt.setString(2, pickup);
            stmt.setString(3, drop);
            stmt.setString(4, vehicleType);
            stmt.setDouble(5, fare);
            stmt.setString(6, paymentMethod);
            stmt.executeUpdate();

            response.sendRedirect("viewMyBookings.jsp"); // Redirect to booking history page
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Handle errors
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
