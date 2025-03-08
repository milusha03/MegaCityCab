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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">Mega City Cab Admin</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link active" href="adminBookings.jsp">Manage Ride Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="viewCustomers.jsp">View Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="addAdmin.jsp">Add New Admin</a></li>
                <li class="nav-item"><a class="nav-link" href="addDrivers.jsp">Add New Drivers</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Manage Ride Bookings</h2>

        <table class="table table-bordered">
            <thead>
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
            </thead>
            <tbody>
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
                            <form action="AdminBookingServlet" method="post" style="display: inline-block;">
                                <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                                <button type="submit" name="action" value="Approve" class="btn btn-success btn-sm">Approve</button>
                            </form>
                            <form action="AdminBookingServlet" method="post" style="display: inline-block;">
                                <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                                <button type="submit" name="action" value="Reject" class="btn btn-danger btn-sm">Reject</button>
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
            </tbody>
        </table>
            
            <br>
        <a href="adminDashboard.jsp" class="btn btn-warning">Back to Dashboard</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>