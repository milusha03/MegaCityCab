<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" import="java.sql.*, com.megacitycab.utils.DBConnection" %>

<%
    Integer username = (Integer) session.getAttribute("customer_id");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Help & Guidelines</title>
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
        <h2>Help & System Guidelines</h2>
        <p>Welcome to the Mega City Cab system! Here’s how you can use our platform effectively:</p>

        <h4>1. Booking a Ride</h4>
        <p>Click on the <strong>“Book a Ride”</strong> button, enter your pickup, drop-off locations, distance and select a
            vehicle type and confirm your booking.</p>

        <h4>2. Viewing Your Bookings</h4>
        <p>Click on <strong>“My Bookings”</strong> to see all your past and upcoming rides.</p>

        <h4>3. Viewing Your Receipts</h4>
        <p>Click on <strong>“Receipts”</strong> to see your receipts.</p>
        
        <h4>4. Updating Your Profile</h4>
        <p>Go to <strong>“Profile”</strong> to update your personal details and contact information.</p>

        <h4>5. Logging Out</h4>
        <p>Click on the <strong>“Logout”</strong> button when you're done to ensure your account is secure.</p>

        <a href="customerDashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
