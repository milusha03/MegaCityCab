<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>
<%@ page session="true" %>

<%
    // Check if user is logged in
    Integer customerId = (Integer) session.getAttribute("customer_id");
    if (customerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch vehicle types from the database
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book a Ride</title>
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
    </style>
    <script>
        function calculateFare() {
            var vehicleType = document.getElementById("vehicleType").value; // Get selected vehicle type
            var distance = parseFloat(document.getElementById("distance").value); // Get the entered distance (km)
            var baseFare = 0;

            // Set fare based on vehicle type
            if (vehicleType === "Bike") baseFare = 5;
            else if (vehicleType === "Car") baseFare = 10;
            else if (vehicleType === "Minivan") baseFare = 20;
            else if (vehicleType === "Van") baseFare = 25;
            else {
                alert("Please select a valid vehicle type.");
                return;
            }

            // Ensure the distance is a valid number and greater than 0
            if (isNaN(distance) || distance <= 0) {
                alert("Please enter a valid distance.");
                return;
            }

            // Fare calculation logic (baseFare × distance)
            var estimatedFare = baseFare * distance;
            document.getElementById("fare").value = estimatedFare.toFixed(2); // Display the calculated fare
        }

        function validateForm() {
            var vehicleType = document.getElementById("vehicleType").value;
            if (vehicleType === "") {
                alert("Please select a vehicle type before booking.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="customerDashboard.jsp">Mega City Cab</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="customerDashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="bookRide.jsp">Book a Ride</a></li>
                <li class="nav-item"><a class="nav-link" href="viewBookings.jsp">My Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="updateProfile.jsp">Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Book a Ride</h2>

        <form action="BookRideServlet" method="post" onsubmit="return validateForm();">
            <div class="form-group">
                <label for="pickup">Pickup Location:</label>
                <input type="text" id="pickup" name="pickup" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="drop">Drop Location:</label>
                <input type="text" id="drop" name="drop" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="distance">Distance (km):</label>
                <input type="number" id="distance" name="distance" class="form-control" min="1" required onchange="calculateFare()">
            </div>

            <div class="form-group">
                <label for="vehicleType">Select Vehicle Type:</label>
                <select name="vehicleType" id="vehicleType" class="form-control" onchange="calculateFare()" required>
                    <option value="">-- Select Vehicle --</option>
                    <%
                        try {
                            conn = DBConnection.getConnection();
                            stmt = conn.prepareStatement("SELECT DISTINCT vehicle_type FROM vehicles");
                            rs = stmt.executeQuery();
                            while (rs.next()) {
                                String vehicleType = rs.getString("vehicle_type");
                    %>
                                <option value="<%= vehicleType %>"><%= vehicleType %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="fare">Estimated Fare (Rs.):</label>
                <input type="text" id="fare" name="fare" class="form-control" readonly>
            </div>

            <div class="form-group">
                <label for="paymentMethod">Select Payment Method:</label>
                <select name="paymentMethod" id="paymentMethod" class="form-control" required>
                    <option value="Cash">Cash</option>
                    <option value="Card">Credit/Debit Card</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Book Now</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
