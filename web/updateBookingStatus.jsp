<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>

<%
    int bookingId = Integer.parseInt(request.getParameter("booking_id"));
    String action = request.getParameter("action");
    int driverId = Integer.parseInt(request.getParameter("driver_id"));
    String status = "";

    if ("accept".equals(action)) {
        status = "Approved";
    } else if ("cancel".equals(action)) {
        status = "Canceled";
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = DBConnection.getConnection();
        String updateBookingSql = "UPDATE bookings SET status = ?, driver_id = ?, vehicle_number = ? WHERE booking_id = ?";
        stmt = conn.prepareStatement(updateBookingSql);
        stmt.setString(1, status);

        // Fetch the vehicle number of the assigned driver
        String vehicleNumber = "";
        String vehicleSql = "SELECT vehicle_number FROM drivers WHERE driver_id = ?";
        PreparedStatement vehicleStmt = conn.prepareStatement(vehicleSql);
        vehicleStmt.setInt(1, driverId);
        ResultSet vehicleRs = vehicleStmt.executeQuery();
        if (vehicleRs.next()) {
            vehicleNumber = vehicleRs.getString("vehicle_number");
        }

        stmt.setInt(2, driverId);
        stmt.setString(3, vehicleNumber);
        stmt.setInt(4, bookingId);

        stmt.executeUpdate();
        response.sendRedirect("adminBookings.jsp");  // Redirect back to the bookings page
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error updating booking: " + e.getMessage());
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
