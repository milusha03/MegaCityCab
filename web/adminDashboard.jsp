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
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Welcome, Admin</h2>

    <nav>
        <ul>
            <li><a href="adminBookings.jsp">Manage Ride Bookings</a></li>
            <li><a href="viewCustomers.jsp">View Customers</a></li>
            <li><a href="addAdmin.jsp">Add New Admin</a></li>
            <li><a href="addDrivers.jsp">Add New Drivers</a></li>
            <li><a href="adminLogout.jsp">Logout</a></li>
        </ul>
    </nav>

</body>
</html>
