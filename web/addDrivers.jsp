<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.megacitycab.utils.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Drivers</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">Mega City Cab Admin</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="adminBookings.jsp">Manage Ride Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="viewCustomers.jsp">View Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="addAdmin.jsp">Add New Admin</a></li>
                <li class="nav-item"><a class="nav-link active" href="addDrivers.jsp">Add New Drivers</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Add New Driver</h2>

        <form action="AddDriverServlet" method="post">
            <div class="form-group">
                <label for="full_name">Full Name:</label>
                <input type="text" class="form-control" id="full_name" name="full_name" required>
            </div>
            <div class="form-group">
                <label for="license_number">License Number:</label>
                <input type="text" class="form-control" id="license_number" name="license_number" required>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number:</label>
                <input type="text" class="form-control" id="phone_number" name="phone_number" required>
            </div>
            <div class="form-group">
                <label for="vehicle_number">Vehicle Number:</label>
                <input type="text" class="form-control" id="vehicle_number" name="vehicle_number" required>
            </div>
            <div class="form-group">
                <label for="vehicle_type">Vehicle Type:</label>
                <input type="text" class="form-control" id="vehicle_type" name="vehicle_type" required>
            </div>
            <div class="form-group">
                <label for="capacity">Capacity:</label>
                <input type="number" class="form-control" id="capacity" name="capacity" required>
            </div>
            <input type="submit" class="btn btn-warning" value="Add Driver">
        </form>

        <h2>Driver List</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>License Number</th>
                    <th>Phone Number</th>
                    <th>Vehicle Number</th>
                    <th>Vehicle Type</th>
                    <th>Capacity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT * FROM drivers";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("full_name") %></td>
                    <td><%= rs.getString("license_number") %></td>
                    <td><%= rs.getString("phone_number") %></td>
                    <td><%= rs.getString("vehicle_number") %></td>
                    <td><%= rs.getString("vehicle_type") %></td>
                    <td><%= rs.getInt("capacity") %></td>
                    <td>
                        <form action="DeleteDriverServlet" method="post" style="display:inline;">
                            <input type="hidden" name="driver_id" value="<%= rs.getInt("driver_id") %>">
                            <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                        </form>
                        <form action="UpdateDriverServlet" method="post" style="display:inline;">
                            <input type="hidden" name="driver_id" value="<%= rs.getInt("driver_id") %>">
                            <input type="submit" class="btn btn-primary btn-sm" value="Edit">
                        </form>
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