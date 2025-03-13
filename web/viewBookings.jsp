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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .btn-primary {
            background-color: #3f51b5;
            border-color: #3f51b5;
        }

        .btn-primary:hover {
            background-color: #303f9f;
            border-color: #303f9f;
        }

        .navbar-light .navbar-nav .nav-link {
            color: #343a40;
        }

        .navbar-light .navbar-nav .nav-link:hover {
            color: #1d2124;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="customerDashboard.jsp">Mega City Cab</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link active" href="customerDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="bookRide.jsp">Book a Ride</a></li>
                <li class="nav-item"><a class="nav-link" href="viewBookings.jsp">My Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="bookingReceipt.jsp">Receipts</a></li>
                <li class="nav-item"><a class="nav-link" href="updateProfile.jsp">Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="help.jsp">Help</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>My Bookings</h2>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Driver Name</th>
                    <th>Vehicle Number</th>
                    <th>Vehicle Type</th>
                    <th>Distance (km)</th>
                    <th>Booking Date</th>
                    <th>Fare</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DBConnection.getConnection();

                        String sql = "SELECT b.booking_id, b.pickup_location, b.drop_location, v.vehicle_type, b.fare, " +
                                "b.payment, b.status, d.full_name, v.vehicle_number, b.distance, b.booking_date " +
                                "FROM bookings b " +
                                "LEFT JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                                "LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                                "WHERE b.customer_id = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, customerId);
                        rs = stmt.executeQuery();

                        boolean bookingsFound = false;
                        while (rs.next()) {
                            bookingsFound = true;
                %>
                            <tr>
                                <td><%= rs.getInt("booking_id") %></td>
                                <td><%= rs.getString("pickup_location") %></td>
                                <td><%= rs.getString("drop_location") %></td>
                                <td><%= rs.getString("full_name") %></td>
                                <td><%= rs.getString("vehicle_number") %></td>
                                <td><%= rs.getString("vehicle_type") %></td>
                                <td><%= rs.getDouble("distance") %> km</td>
                                <td><%= rs.getTimestamp("booking_date") %></td>
                                <td>Rs.<%= rs.getDouble("fare") %></td>
                                <td><%= rs.getString("payment") %></td>
                                <td><%= rs.getString("status") %></td>
                            </tr>
                <%
                        }
                        if (!bookingsFound) {
                            out.println("<tr><td colspan='11'>No bookings found.</td></tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>

        <a href="customerDashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>