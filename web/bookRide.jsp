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

    // Fetch vehicle types from database
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book a Ride</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script>
        function calculateFare() {
            var vehicleType = document.getElementById("vehicleType").value;
            var baseFare = 0;

            // Set fare based on vehicle type (Sample values, update accordingly)
            if (vehicleType === "Sedan") baseFare = 10;
            else if (vehicleType === "SUV") baseFare = 15;
            else if (vehicleType === "Luxury") baseFare = 25;
            
            // Fare calculation logic (Modify based on distance, etc.)
            var estimatedFare = baseFare * 5; // Example: base fare × 5km distance
            
            document.getElementById("fare").value = estimatedFare.toFixed(2);
        }
    </script>
</head>
<body>
    <h2>Book a Ride</h2>

    <form action="BookRideServlet" method="post">
        <label for="pickup">Pickup Location:</label>
        <input type="text" name="pickup" required>
        
        <label for="drop">Drop Location:</label>
        <input type="text" name="drop" required>
        
        <label for="vehicleType">Select Vehicle Type:</label>
        <select name="vehicleType" id="vehicleType" onchange="calculateFare()" required>
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
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </select>

        <label for="fare">Estimated Fare ($):</label>
        <input type="text" id="fare" name="fare" readonly>

        <label for="paymentMethod">Select Payment Method:</label>
        <select name="paymentMethod" required>
            <option value="Cash">Cash</option>
            <option value="Card">Credit/Debit Card</option>
        </select>
        
        <button type="submit">Book Now</button>
    </form>
</body>
</html>
