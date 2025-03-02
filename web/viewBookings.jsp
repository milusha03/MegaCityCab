<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>
<%@ page session="true" %>

<%
    Integer customerId = (Integer) session.getAttribute("customer_id");
    if (customerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>My Bookings</h2>

    <table border="1">
        <tr>
            <th>Booking ID</th>
            <th>Pickup Location</th>
            <th>Drop Location</th>
            <th>Driver</th>
            <th>Contact Number</th>
            <th>Vehicle Type</th>
            <th>Fare</th>
            <th>Payment Method</th>
            <th>Status</th>
        </tr>

        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT b.booking_id, b.pickup_location, b.drop_location, v.vehicle_type, b.fare, b.payment_method, b.status " +
                             "FROM bookings b JOIN vehicles v ON b.vehicle_id = v.vehicle_id WHERE b.customer_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, customerId);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("booking_id") %></td>
                        <td><%= rs.getString("pickup_location") %></td>
                        <td><%= rs.getString("drop_location") %></td>
                        <td><%= rs.getString("vehicle_type") %></td>
                        <td>$<%= rs.getDouble("fare") %></td>
                        <td><%= rs.getString("payment_method") %></td>
                        <td><%= rs.getString("status") %></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>
