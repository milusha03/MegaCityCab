<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" import="java.sql.*, com.megacitycab.utils.DBConnection" %>

<%
    // Check if admin is logged in
    Integer adminId = (Integer) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Manage Ride Bookings</h2>

    <table border="1">
        <tr>
            <th>Booking ID</th>
            <th>Customer</th>
            <th>Pickup</th>
            <th>Drop</th>
            <th>Vehicle</th>
            <th>Fare</th>
            <th>Status</th>
            <th>Payment Method</th>
            <th>Action</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT b.booking_id, c.name AS customer_name, b.pickup_location, b.drop_location, " +
                                                  "v.vehicle_type, b.fare, b.status, b.payment_method " +
                                                  "FROM bookings b " +
                                                  "JOIN customers c ON b.customer_id = c.customer_id " +
                                                  "JOIN vehicles v ON b.vehicle_id = v.vehicle_id")) {
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("booking_id") %></td>
            <td><%= rs.getString("customer_name") %></td>
            <td><%= rs.getString("pickup_location") %></td>
            <td><%= rs.getString("drop_location") %></td>
            <td><%= rs.getString("vehicle_type") %></td>
            <td>$<%= rs.getDouble("fare") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getString("payment_method") %></td>
            <td>
                <% if (rs.getString("status").equals("Pending")) { %>
                    <form action="AdminBookingServlet" method="post">
                        <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                        <button type="submit" name="action" value="Approve">Approve</button>
                        <button type="submit" name="action" value="Reject">Reject</button>
                    </form>
                <% } else { %>
                    <%= rs.getString("status") %>
                <% } %>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
