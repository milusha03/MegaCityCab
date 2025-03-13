<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Check if admin is logged in
    Integer username = (Integer) session.getAttribute("admin_id");
    if (username == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">Mega City Cab Admin</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link active" href="adminDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="adminBookings.jsp">Manage Ride Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="viewCustomers.jsp">View Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="addAdmin.jsp">Add New Admin</a></li>
                <li class="nav-item"><a class="nav-link" href="addDrivers.jsp">Add New Drivers</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Welcome, Admin</h2>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Manage Ride Bookings</h5>
                        <p class="card-text">View, approve, and manage ride bookings.</p>
                        <a href="adminBookings.jsp" class="btn btn-warning">Go to Bookings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">View Customers</h5>
                        <p class="card-text">View and manage customer information.</p>
                        <a href="viewCustomers.jsp" class="btn btn-warning">View Customers</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Add New Admin</h5>
                        <p class="card-text">Add new administrators to the system.</p>
                        <a href="addAdmin.jsp" class="btn btn-warning">Add Admin</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Add New Drivers</h5>
                        <p class="card-text">Add new drivers to the system.</p>
                        <a href="addDrivers.jsp" class="btn btn-warning">Add Driver</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>