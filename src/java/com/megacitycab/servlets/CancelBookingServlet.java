package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class CancelBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacity_cab", "root", "password");

            PreparedStatement stmt = conn.prepareStatement("UPDATE bookings SET status = 'Cancelled' WHERE booking_id = ?");
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();

            conn.close();
            response.sendRedirect("viewBookings.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
