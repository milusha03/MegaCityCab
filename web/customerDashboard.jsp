<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" import="java.sql.*, com.megacitycab.utils.DBConnection" %>

<%
    // Check if user is logged in
    Integer username = (Integer) session.getAttribute("customer_id");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
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
        <h2>Welcome, <%= session.getAttribute("full_name") %>!</h2>

        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Book a Ride</h5>
                        <p class="card-text">Book your next ride with us.</p>
                        <a href="bookRide.jsp" class="btn btn-primary">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">View My Bookings</h5>
                        <p class="card-text">View your past and upcoming bookings.</p>
                        <a href="viewBookings.jsp" class="btn btn-primary">View Bookings</a>
                    </div>
                </div>
            </div>
                        <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">View My Receipts</h5>
                        <p class="card-text">View the receipts for your bookings.</p>
                        <a href="viewBookings.jsp" class="btn btn-primary">View Receipts</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Update Profile</h5>
                        <p class="card-text">Update your profile information.</p>
                        <a href="updateProfile.jsp" class="btn btn-primary">Update Profile</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Help & Guidelines</h5>
                        <p class="card-text">Learn how to use the system.</p>
                        <a href="help.jsp" class="btn btn-primary">Get Help</a>
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
