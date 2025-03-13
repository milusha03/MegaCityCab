<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.model.Driver" %>

<html>
<head>
    <title>Edit Driver</title>
</head>
<body>

    <h2>Edit Driver</h2>

    <%
        Driver driver = (Driver) request.getAttribute("driver");
        String error = (String) request.getAttribute("error");

        if (error != null) {
    %>
        <p style="color: red;"><%= error %></p>
    <%
        }

        if (driver == null) {
            return;
        }
    %>

    <form action="UpdateDriverServlet" method="GET">
        <input type="hidden" name="driver_id" value="<%= driver.getDriverId() %>">
        
        <label>Full Name:</label>
        <input type="text" name="full_name" value="<%= driver.getFullName() != null ? driver.getFullName() : "" %>" required><br>

        <label>License Number:</label>
        <input type="text" name="license_number" value="<%= driver.getLicenseNumber() != null ? driver.getLicenseNumber() : "" %>" required><br>

        <label>Phone Number:</label>
        <input type="text" name="phone_number" value="<%= driver.getPhoneNumber() != null ? driver.getPhoneNumber() : "" %>" required><br>

        <label>Address:</label>
        <input type="text" name="address" value="<%= driver.getAddress() != null ? driver.getAddress() : "" %>" required><br>

        <button type="submit">Update</button>
    </form>
        
        

</body>
</html>
