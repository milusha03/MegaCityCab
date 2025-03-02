<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

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
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("full_name") %>!</h2>
    <ul>
        <li><a href="bookRide.jsp">📌 Book a Ride</a></li>
        <li><a href="viewBookings.jsp">📅 View My Bookings</a></li>
        <li><a href="updateProfile.jsp">🛠 Update Profile</a></li>
        <li><a href="logout.jsp">🚪 Logout</a></li>
    </ul>
</body>
</html>
