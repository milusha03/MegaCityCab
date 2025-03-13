<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>
<%@ page session="true" %>

<%
    // Ensure that the admin is logged in
    Integer adminId = (Integer) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Bookings</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">Mega City Cab Admin</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="adminBookings.jsp">Manage Ride Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="viewCustomers.jsp">View Customers</a></li>
                <li class="nav-item"><a class="nav-link active" href="addAdmin.jsp">Add New Admin</a></li>
                <li class="nav-item"><a class="nav-link" href="addDrivers.jsp">Add New Drivers</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Pending Bookings</h2>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Customer Name</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Distance</th>
                    <th>Booking Date</th>
                    <th>Fare</th>
                    <th>Payment Method</th>
                    <th>Vehicle Type</th>
                    <th>Driver</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DBConnection.getConnection();
                        String sql = "SELECT b.booking_id, c.full_name, b.pickup_location, b.drop_location, " +
                                     "b.distance, b.booking_date, b.fare, b.payment, b.vehicle_type, " +
                                     "b.status FROM bookings b JOIN customers c ON b.customer_id = c.customer_id " +
                                     "WHERE b.status = 'Pending'";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int bookingId = rs.getInt("booking_id");
                            String customerName = rs.getString("full_name");
                            String pickupLocation = rs.getString("pickup_location");
                            String dropLocation = rs.getString("drop_location");
                            double distance = rs.getDouble("distance");
                            java.sql.Timestamp bookingDate = rs.getTimestamp("booking_date");
                            double fare = rs.getDouble("fare");
                            String paymentMethod = rs.getString("payment");
                            String vehicleType = rs.getString("vehicle_type");

                            // Form for the admin to choose driver and update booking status
                %>
                   <form method="post" action="AdminBookingServlet">
    <tr>
        <td><%= customerName %></td>
        <td><%= pickupLocation %></td>
        <td><%= dropLocation %></td>
        <td><%= distance %> km</td>
        <td><%= bookingDate %></td>
        <td><%= fare %></td>
        <td><%= paymentMethod %></td>
        <td><%= vehicleType %></td>
        <td>
            <select name="driver_id" class="form-control">
                <% 
                    String driverSql = "SELECT driver_id, full_name FROM drivers WHERE vehicle_type = ?";
                    PreparedStatement driverStmt = conn.prepareStatement(driverSql);
                    driverStmt.setString(1, vehicleType);
                    ResultSet driverRs = driverStmt.executeQuery();
                    while (driverRs.next()) {
                %>
                    <option value="<%= driverRs.getInt("driver_id") %>">
                        <%= driverRs.getString("full_name") %>
                    </option>
                <% 
                    }
                %>
            </select>
        </td>
        <td>
            <select name="action" class="form-control">
                <option value="accept">Accept</option>
                <option value="cancel">Cancel</option>
            </select>
            <input type="hidden" name="booking_id" value="<%= bookingId %>" />
            <button type="submit" class="btn btn-primary mt-2">Submit</button>
        </td>
    </tr>
</form>

                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='10'>Error retrieving data: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
