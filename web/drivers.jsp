<%@ page import="java.util.List" %>
<%@ page import="com.megacitycab.dao.DriverDAO" %>
<%@ page import="com.megacitycab.model.Driver" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <title>Drivers List</title>
</head>
<body>
    <h2>Driver List</h2>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>License No</th>
            <th>Contact</th>
            <th>Actions</th>
        </tr>
        <%
            DriverDAO driverDAO = new DriverDAO();
            List<Driver> drivers = driverDAO.getAllDrivers();
            for (Driver driver : drivers) {
        %>
        <tr>
            <td><%= driver.getId() %></td>
            <td><%= driver.getName() %></td>
            <td><%= driver.getLicenseNumber() %></td>
            <td><%= driver.getContact() %></td>
            <td>
                <a href="EditDriverServlet?driverId=<%= driver.getId() %>">Edit</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
