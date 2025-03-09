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
        if (driver == null) {
            out.println("<p>Driver not found!</p>");
            return;
        }
    %>
    <form action="UpdateDriverServlet" method="POST">
    <input type="hidden" name="driver_id" value="${driver.driverId}">
    <input type="text" name="full_name" value="${driver.fullName}">
    <input type="text" name="license_number" value="${driver.licenseNumber}">
    <input type="text" name="phone_number" value="${driver.phoneNumber}">
    <input type="text" name="address" value="${driver.address}">
    <button type="submit">Update</button>
</form>



</body>
</html>
