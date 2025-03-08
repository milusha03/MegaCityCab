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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">Mega City Cab Admin</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="adminBookings.jsp">Manage Ride Bookings</a></li>
                <li class="nav-item"><a class="nav-link active" href="viewCustomers.jsp">View Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="addAdmin.jsp">Add New Admin</a></li>
                <li class="nav-item"><a class="nav-link" href="addDrivers.jsp">Add New Drivers</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Customer List</h2>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Address</th>
                    <th>NIC</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Username</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
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
                            <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='7'>Error loading customers.</td></tr>");
                    }
                %>
            </tbody>
        </table>

        <br>
        <a href="adminDashboard.jsp" class="btn btn-warning">Back to Dashboard</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>