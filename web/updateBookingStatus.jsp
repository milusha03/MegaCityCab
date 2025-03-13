<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>
<%@ page session="true" %>

<%
    // Ensure the admin is logged in
    Integer adminId = (Integer) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // Get the parameters from the form
    String action = request.getParameter("action");
    int bookingId = Integer.parseInt(request.getParameter("booking_id"));
    int driverId = Integer.parseInt(request.getParameter("driver_id"));
    String status = action.equals("Pending") ? "Approved" : "Rejected" ;
    int vehicleId = -1; // Default to -1 if it's rejected

    // Debugging Output
    out.println("<p>Action: " + action + ", Booking ID: " + bookingId + ", Driver ID: " + driverId + "</p>"); // Debugging line

    // Connection and update logic
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();

        if ("accept".equals(action)) {
            // Get the vehicle_id associated with the selected driver
            String driverQuery = "SELECT vehicle_id FROM vehicles WHERE vehicle_number = ?";
            stmt = conn.prepareStatement(driverQuery);
            stmt.setInt(1, driverId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                vehicleId = rs.getInt("vehicle_id");
            }
            out.println("<p>Vehicle ID: " + vehicleId + "</p>"); // Debugging line

            // Update the booking status, driver_id, and vehicle_id
            String updateQuery = "UPDATE bookings SET status = ?, driver_id = ?, vehicle_id = ? WHERE booking_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setInt(2, driverId);
            stmt.setInt(3, vehicleId);
            stmt.setInt(4, bookingId);
        } else if ("cancel".equals(action)) {
            // Update the booking status to "Rejected" without changing driver_id or vehicle_id
            String updateQuery = "UPDATE bookings SET status = ? WHERE booking_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
        }

        int updated = stmt.executeUpdate();
        out.println("<p>Rows Updated: " + updated + "</p>"); // Debugging line

        if (updated > 0) {
            response.sendRedirect("adminBookings.jsp?success=Booking " + status.toLowerCase());
        } else {
            response.sendRedirect("adminBookings.jsp?error=Failed to update booking.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("adminBookings.jsp?error=Database error.");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
