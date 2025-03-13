<%@ page isErrorPage="true" %>
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

    // Get parameters from the form
    String action = request.getParameter("action");
    String bookingIdStr = request.getParameter("booking_id");
    String driverIdStr = request.getParameter("driver_id");
    String vehicleIdStr = request.getParameter("vehicle_id");

    // Validate input parameters
    if (action == null || bookingIdStr == null) {
        response.sendRedirect("adminBookings.jsp?error=Invalid input data.");
        return;
    }

    int bookingId = 0, driverId = 0, vehicleId = 0;
    try {
        bookingId = Integer.parseInt(bookingIdStr);
        if (action.equals("accept") || action.equals("complete")) {
            if (driverIdStr == null || vehicleIdStr == null) {
                response.sendRedirect("adminBookings.jsp?error=Driver and vehicle required.");
                return;
            }
            driverId = Integer.parseInt(driverIdStr);
            vehicleId = Integer.parseInt(vehicleIdStr);
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("adminBookings.jsp?error=Invalid booking, driver, or vehicle ID.");
        return;
    }

    // Determine the status based on action
    String status = "";
    if ("accept".equals(action)) {
        status = "Approved";
    } else if ("cancel".equals(action)) {
        status = "Rejected";
    } else if ("complete".equals(action)) {
        status = "Completed";
    } else {
        response.sendRedirect("adminBookings.jsp?error=Invalid action.");
        return;
    }

    // Debugging Output (remove in production)
    System.out.println("Action: " + action + ", Booking ID: " + bookingId + ", Driver ID: " + driverId + ", Vehicle ID: " + vehicleId);

    // Connection and update logic
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = DBConnection.getConnection();
        if (conn == null) {
            response.sendRedirect("adminBookings.jsp?error=Database connection failed.");
            return;
        }

        if ("accept".equals(action)) {
            // Update booking status, assign driver, and vehicle
            String updateQuery = "UPDATE bookings SET status = ?, driver_id = ?, vehicle_id = ? WHERE booking_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setInt(2, driverId);
            stmt.setInt(3, vehicleId);
            stmt.setInt(4, bookingId);
        } else if ("cancel".equals(action)) {
            // Update only status to "Rejected"
            String updateQuery = "UPDATE bookings SET status = ? WHERE booking_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
        } else if ("complete".equals(action)) {
            // Update status to "Completed"
            String updateQuery = "UPDATE bookings SET status = ? WHERE booking_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
        }

        int updated = stmt.executeUpdate();
        if (updated > 0) {
            response.sendRedirect("adminBookings.jsp?success=Booking " + status.toLowerCase());
        } else {
            response.sendRedirect("adminBookings.jsp?error=Failed to update booking.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("adminBookings.jsp?error=Database error.");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
