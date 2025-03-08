<%@ page import="java.sql.*, com.megacitycab.utils.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Check if admin is logged in
    Integer adminId = (Integer) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Customers</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h2>Customer List</h2>

    <table border="1">
        <tr>
            <th>Full Name</th>
            <th>Address</th>
            <th>NIC</th>
            <th>Phone Number</th>
            <th>Email</th>
            <th>Username</th>
            <th>Action</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT customer_id, full_name, address, nic, phone_number, email, username FROM customers";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("full_name") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("nic") %></td>
            <td><%= rs.getString("phone_number") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("username") %></td>
            <td>
                <form action="DeleteCustomerServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this customer?');">
                    <input type="hidden" name="customer_id" value="<%= rs.getInt("customer_id") %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<tr><td colspan='6'>Error loading customers.</td></tr>");
            }
        %>
    </table>

    <br>
    <a href="adminDashboard.jsp">Back to Dashboard</a>
</body>
</html>
