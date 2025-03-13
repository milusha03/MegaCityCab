<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // Check if the user is logged in
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("customer_id") == null) {
        out.println("<h3 style='color: red;'>User session not found. Please log in again.</h3>");
        return;
    }

    int userId = (int) sessionUser.getAttribute("customer_id");

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/megacitycab";
    String dbUser = "root";
    String dbPass = "mysql"; // Replace with actual password

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "SELECT b.booking_id, d.full_name, d.phone_number, v.vehicle_number, b.vehicle_type, " +
                     "b.pickup_location, b.drop_location, b.distance, b.fare, b.payment " +
                     "FROM bookings b " +
                     "JOIN drivers d ON b.driver_id = d.driver_id " +
                     "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                     "WHERE b.customer_id = ? AND b.status = 'Approved'";

        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Receipts</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .btn-primary {
            background-color: #3f51b5; /* Blue button */
            border-color: #3f51b5;
        }

        .btn-primary:hover {
            background-color: #303f9f;
            border-color: #303f9f;
        }

        .navbar-light .navbar-nav .nav-link {
            color: #343a40; /* Dark gray color for nav links */
        }

        .navbar-light .navbar-nav .nav-link:hover {
            color: #1d2124; /* Slightly darker gray on hover */
        }

        .form-control {
            margin-bottom: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }
        
        .receipt-container {
    width: 60%;
    margin: 20px auto;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    font-family: Arial, sans-serif;
}

.receipt-header {
    font-size: 22px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 10px;
    color: #3f51b5;
}

.receipt-details p {
    font-size: 16px;
    margin: 5px 0;
    padding: 5px;
    border-bottom: 1px solid #ddd;
}

.receipt-details strong {
    color: #343a40;
}

.btn-print {
    display: block;
    width: 100%;
    text-align: center;
    background: #3f51b5;
    color: #fff;
    padding: 10px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}

.btn-print:hover {
    background: #303f9f;
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

<%
    boolean hasBookings = false;

    while (rs.next()) {
        hasBookings = true;
%>
    <div class="receipt-container">
        <div class="receipt-header">MegaCity Cab Booking Receipt</div>
        <hr>
        <div class="receipt-details">
            <p><strong>Booking ID:</strong> <%= rs.getInt("booking_id") %></p>
            <p><strong>Driver Name:</strong> <%= rs.getString("full_name") %></p>
            <p><strong>Driver Phone:</strong> <%= rs.getString("phone_number") %></p>
            <p><strong>Vehicle Number:</strong> <%= rs.getString("vehicle_number") %></p>
            <p><strong>Vehicle Type:</strong> <%= rs.getString("vehicle_type") %></p>
            <p><strong>Pickup Location:</strong> <%= rs.getString("pickup_location") %></p>
            <p><strong>Drop Location:</strong> <%= rs.getString("drop_location") %></p>
            <p><strong>Distance:</strong> <%= rs.getDouble("distance") %> km</p>
            <p><strong>Fare:</strong> Rs.<%= rs.getDouble("fare") %></p>
            <p><strong>Payment Method:</strong> <%= rs.getString("payment") %></p>
        </div>
        <hr>
        <button class="btn-print" onclick="window.print()">Print Receipt</button>
    </div>
    <br>

<%
    }
    if (!hasBookings) {
%>
    <h3 style='color: red; text-align: center;'>No Approved Bookings Found!</h3>
<%
    }
} catch (Exception e) {
    out.println("<h3 style='color: red; text-align: center;'>Error: " + e.getMessage() + "</h3>");
} finally {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
%>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
</body>
</html>
