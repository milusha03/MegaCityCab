<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Customer Registration</h2>
    <form action="CustomerServlet" method="post">
        <label>Full Name:</label>
        <input type="text" name="fullName" required>
        
        <label>Address:</label>
        <input type="text" name="address" required>
        
        <label>NIC:</label>
        <input type="text" name="nic" required>
        
        <label>Phone Number:</label>
        <input type="text" name="phone" required>
        
        <label>Email:</label>
        <input type="email" name="email" required>
        
        <label>Username:</label>
        <input type="text" name="username" required>
        
        <label>Password:</label>
        <input type="password" name="password" required>
        
        <button type="submit">Register</button>
    </form>
</body>
</html>
